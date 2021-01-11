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
  var currentQuestion: Int {get set}
  var fetching: Bool {get set}
  var playerOne: Player {get set}
  var playerTwo: Player {get set}
}

protocol SettingsStateProtocol {
  var numberOfLaunches: Int {get set}
  var appState: currentView {get set}
}


