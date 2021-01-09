//
//  GameStore.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine

protocol GameStoreProtocol {
  var currentQuestion: Question {get set}
  var playerOne: Player {get set}
  var playerTwo: Player {get set}
  func fetch() -> AnyPublisher<[Question], ApiError>
  func next(question: Question) -> Void
  func reset() -> Void
  func check(answer: String)
}

final class GameStore: GameStoreProtocol {
  
  var cancellables = [AnyCancellable]()
  
  @Storage(key: AppSettingsKeys.playerOne.rawValue, defaultValue: Player.empty)
  var playerOne: Player
  
  @Storage(key: AppSettingsKeys.playerTwo.rawValue, defaultValue: Player.empty)
  var playerTwo: Player
  
  @Storage(key: AppSettingsKeys.currentQuestion.rawValue, defaultValue: Question.empty)
  var currentQuestion: Question
  
  
  func getQuestions()  -> AnyPublisher<QuestionResponse, ApiError>{
    return ServiceLayer.shared.run(Router.questions)
  }
  
  func fetch() -> AnyPublisher<[Question], ApiError> {
    return Future<[Question], ApiError> { promise in
      self.getQuestions().on(success: {
          promise(.success($0.results))
      }, failure: {
        promise(.failure($0))
      }).store(in: &self.cancellables)
    }.subscribe(on: DispatchQueue.main)
    
    .eraseToAnyPublisher()
  }
  
  private func incrementScore() {
    if playerOne.isCurrentTurn {
    playerOne.score = playerOne.score + 1
  }else {
    playerTwo.score = playerTwo.score + 1
  }
  
  func switchTurn() {
    if playerOne.isCurrentTurn{
      playerOne.isCurrentTurn = false
      playerTwo.isCurrentTurn = true
    }else {
      playerOne.isCurrentTurn = true
      playerTwo.isCurrentTurn = false
    }
  }
  
  
  func check(answer: String) {
    if currentQuestion.correct_answer == answer {
      incrementScore()
    }
  }
  
  func next(question: Question) {
    currentQuestion = question
    switchTurn()
  }
  
  func reset() {
    playerOne = Player.empty
    playerTwo = Player.empty
    currentQuestion = Question.empty
  }
  
}

