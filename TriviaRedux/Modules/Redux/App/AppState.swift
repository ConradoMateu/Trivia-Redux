//
//  AppState.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import Combine
struct AppState {
  var settings: SettingsStateProtocol
  var game: GameStateProtocol
}

protocol GameStateProtocol {
  var nextQuestion: PassthroughSubject<Question, Never> {get set}
  var isCorrectAnswer: PassthroughSubject<Bool, Never> {get set}
  var questions: [Question] {get set}
  var endGame: PassthroughSubject<Bool, Never> {get set}
  var currentQuestionIdx: Int {get set}
  var fetching: Bool {get set}
  var playerOne: Player {get set}
  var playerTwo: Player {get set}
  var buttonStates: [ButtonState] {get set}
  var disableButtons: Bool {get set}
  var currentAnswers: [String] {get set}
  var currentQuestion: Question {get}
  func shuffleAnswers() -> [String]
}

extension GameStateProtocol {
  func findCurrentAnserIndex() -> Int{
    for i in 0..<currentAnswers.count{
      if currentAnswers[i] == currentQuestion.correct_answer{
        print("\(currentAnswers[i]) == \(currentQuestion.correct_answer): \(i)")
        return i
      }
    }
    return -1
  }

  func shuffleAnswers() -> [String] {
    currentQuestion.flattenedAnswers.shuffled()
  }
  
  func checkQuestion(for i: Int) -> [ButtonState] {
    var res = buttonStates
    if currentAnswers[i] == currentQuestion.correct_answer {
      res[i] = .sucessful
    }else{
      res[findCurrentAnserIndex()] = .sucessful
      res[i] = .failed
    }
return res
  }
  
  func reduce(buttonIdx: Int, for answerState: AnswerState) -> [ButtonState]{
    var res = buttonStates
    switch answerState {
    case .notAnswered:
      return ButtonState.notAnsweredState
    case .answered:
      res[buttonIdx] = .checking
      return res
    case .checked:
      return checkQuestion(for: buttonIdx)
  }
  }
    //Reduce if Buttons are disabled, to be active all buttons should be in state 
    func buttonsShouldBeDisabled() -> Bool{
      let totalButtonsInNormalState = self.buttonStates.filter{ state in
        state == .normal
        
      }
      return totalButtonsInNormalState.count != 4
}
}

protocol SettingsStateProtocol {
  var numberOfLaunches: Int {get set}
  var appState: currentView {get set}
}


