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
  case next(question: Question)
  case gameEnded
  case check(answer: String)
}
