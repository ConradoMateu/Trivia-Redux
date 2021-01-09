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
  var currentScorePlayerOne: Int {get set}
  var currentScorePlayerTwo: Int {get set}
  var currentGameTurn:Player {get set}
  func fetch() -> AnyPublisher<[Question], ApiError>
  func next(question: Question) -> Void
  func reset() -> Void
  func check(answer: String)
}

final class GameStore: GameStoreProtocol {
  
  var cancellables = [AnyCancellable]()
  
  @Storage(key: AppSettingsKeys.currentGameTurn.rawValue, defaultValue: .one)
  var currentGameTurn: Player
  
  @Storage(key: AppSettingsKeys.currentQuestion.rawValue, defaultValue: Question.empty)
  var currentQuestion: Question
  
  @Storage(key: AppSettingsKeys.scoreUserOne.rawValue, defaultValue: 0)
  var currentScorePlayerOne: Int
  
  @Storage(key: AppSettingsKeys.scoreUserTwo.rawValue, defaultValue: 0)
  var currentScorePlayerTwo: Int
  
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
    switch currentGameTurn {
    case .one:
      currentScorePlayerOne = 1 + currentScorePlayerOne
    case .two:
      currentScorePlayerTwo = 1 + currentScorePlayerTwo
    }
  }
  
  private func switchTurn() {
    switch currentGameTurn {
    case .one:
      currentGameTurn = .two
    case .two:
      currentGameTurn = .one
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
    currentGameTurn = .one
    currentQuestion = Question.empty
    currentScorePlayerOne = 0
    currentScorePlayerTwo = 0
  }
  
}


enum Player: String, Codable {
  case one
  case two
}
