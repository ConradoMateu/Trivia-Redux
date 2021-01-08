//
//  GameReducer.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation


func gameReducer(state: inout GameState, action: GameAction) -> Void {
    switch action {

    case .fetchComplete(let questions):
      state.questions = questions
    case .next(let question):
      state.nextQuestion.send(question)
    case .gameEnded:
      state.endGame.send(true)
        
    default:
        break
    }

}
