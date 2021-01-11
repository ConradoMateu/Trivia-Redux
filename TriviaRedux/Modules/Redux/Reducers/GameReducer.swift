//
//  GameReducer.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation


func gameReducer(state: inout GameStateProtocol, action: GameAction) -> Void {
    switch action {

    case .fetchComplete(let questions):
      state.fetching = false
      state.questions = questions
      state.currentAnswers = state.shuffleAnswers()
      state.currentQuestionIdx = 0
      state.disableButtons = false
      state.nextQuestion.send(questions.first!)
      
    case .next:
      
      //Check if there are more questions, is there are no more questions the game should end
      if state.currentQuestionIdx+1 < state.questions.count{
        state.currentQuestionIdx = state.currentQuestionIdx + 1
        state.currentAnswers = state.shuffleAnswers()
        state.nextQuestion.send(state.questions[state.currentQuestionIdx])
      }else{
        state.endGame.send(true)
      }
    case .reset:
      state = GameState()
    case .fetch:
      state.fetching = true
    case .login(let playerOne, let playerTwo):
      state.playerOne = playerOne
      state.playerTwo = playerTwo
    case .checkedAnswer(let isCorrectAnswer):
      
      state.isCorrectAnswer.send(isCorrectAnswer)
      
    case .gameEnded:
      state.playerOne.isCurrentTurn = false
      state.playerTwo.isCurrentTurn = false
    case .refreshGame(let playerOne, let playerTwo):
      state.playerOne = playerOne
      state.playerTwo = playerTwo
    case .reduce(let buttonIdx,let answerState):
      state.buttonStates = state.reduce(buttonIdx: buttonIdx, for: answerState)
      state.disableButtons = state.buttonsShouldBeDisabled()
    default:
        break
    }

}
