//
//  Reducer.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

func reducer(state: AppState, action: Action) -> AppState {
  var state = state
  
  switch action {
    case _ as IncrementAction:
      state.counter += 1
    case let action as SetQuestionsAction:
      state.questions = action.questions
    case let action as SetLoginAction:
      state.userOne = action.userOne
      state.userTwo = action.userTwo
      state.appState = .game
    default:
      break
  }
  
  return state
}
