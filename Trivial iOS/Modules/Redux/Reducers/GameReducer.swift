//
//  GameReducer.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation


func gameReducer(state: inout GameStateProtocol, action: GameAction) -> Void {
    switch action {

    case .fetchComplete(let questions):
      state.fetching = false
      state.questions = questions
      state.nextQuestion.send(questions.first!)
      state.currentQuestion = 0
    case .next(let question):
      state.nextQuestion.send(question)
    case .gameEnded:
      state.endGame.send(true)
    case .fetch:
      state.fetching = true
        
    default:
        break
    }

}
