//
//  GameAction.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

enum GameAction {
  case fetch
  case fetchComplete(questions: [Question])
  case fetchError(error: ApiError)
  case next
  case login(playerOne: Player, playerTwo: Player)
  case save(currentQuestion: Question)
  case gameEnded
  case reset
  case check(answer: String)
  case checkedAnswer(isCorrect: Bool)
  case refreshGame(playerOne: Player, playerTwo: Player)
  case reduce(buttonIdx: Int,for: AnswerState)
  case getUsers
}
