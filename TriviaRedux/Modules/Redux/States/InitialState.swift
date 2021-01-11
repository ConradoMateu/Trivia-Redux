//
//  InitialState.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine


struct GameState: GameStateProtocol {
  var playerOne: Player = Player.empty
  var playerTwo: Player = Player.empty
  var questions: [Question] = [Question.empty]
  var fetching: Bool = false
  var isCorrectAnswer = PassthroughSubject<Bool, Never>()
  var nextQuestion = PassthroughSubject<Question, Never>()
  var endGame = PassthroughSubject<Bool, Never>()
  var currentQuestionIdx: Int = 0
  var buttonStates: [ButtonState]  = [.normal, .normal, .normal, .normal]
  var currentAnswers: [String] = ["","","",""]
  var disableButtons: Bool = false
  var currentQuestion: Question{
    questions[currentQuestionIdx]
  }
  }
  

  
  
  


enum AnswerState{
  case notAnswered, answered, checked
}

struct SettingsState: SettingsStateProtocol {
  var numberOfLaunches = 0
  var appState: currentView = .login
}
