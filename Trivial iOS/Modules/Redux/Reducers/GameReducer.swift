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
      state.currentQuestion = 0
      state.nextQuestion.send(questions.first!)
      
    case .next:
      
      //Check if there are more questions, is there are no more questions the game should end
      if state.currentQuestion+1 < state.questions.count{
        state.currentQuestion = state.currentQuestion + 1
        state.nextQuestion.send(state.questions[state.currentQuestion])
      }else{
        state.endGame.send(true)
      }
      
    case .gameEnded:
      state.endGame.send(true)
    case .fetch:
      state.fetching = true
    case .login(let playerOne, let playerTwo):
      state.playerOne = playerOne
      state.playerTwo = playerTwo
    case .checkedAnswer(let isCorrectAnswer):
      state.isCorrectAnswer.send(isCorrectAnswer)
      
    case .refreshGame(let playerOne, let playerTwo):
      state.playerOne = playerOne
      state.playerTwo = playerTwo
    default:
        break
    }

}
