//
//  InitialState.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine

struct LoginState: LoginStateProtocol {
  var playerOne: Player = Player.empty
  var playerTwo: Player = Player.empty
}

struct GameState: GameStateProtocol {
  var fetching: Bool = false
  
  var nextQuestion = PassthroughSubject<Question, Never>()
  var questions: [Question] = [Question]()
  var endGame = PassthroughSubject<Bool, Never>()
  var currentQuestion: Int = -1{
    didSet{
      nextQuestion.send(questions[currentQuestion])
    }
  }
}

struct SettingsState: SettingsStateProtocol {
  var numberOfLaunches = 0
  var appState: currentView = .login
}
