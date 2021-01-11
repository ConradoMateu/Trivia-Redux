//
//  Reducer.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import Combine
typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
//    case .login(let action):
//        loginReducer(state: &state.login, action: action)

    case .settings(let action):
        settingsReducer(state: &state.settings, action: action)
    case.game(let action):
      gameReducer(state: &state.game, action: action)
        
    }
}

