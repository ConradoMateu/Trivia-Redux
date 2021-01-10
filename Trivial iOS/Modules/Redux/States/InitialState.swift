//
//  InitialState.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine


struct GameState: GameStateProtocol {
  var playerOne: Player = Player.empty
  var playerTwo: Player = Player.empty
  var questions: [Question] = [Question]()
  var fetching: Bool = false
  var isCorrectAnswer = PassthroughSubject<Bool, Never>()
  var nextQuestion = PassthroughSubject<Question, Never>()
  var endGame = PassthroughSubject<Bool, Never>()
  var currentQuestion: Int = -1

}

struct SettingsState: SettingsStateProtocol {
  var numberOfLaunches = 0
  var appState: currentView = .login
}
