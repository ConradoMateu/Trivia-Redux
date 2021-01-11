//
//  SettingsReducer.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation

func settingsReducer(state: inout SettingsStateProtocol, action: SettingsAction) -> Void {
  
  switch action {
  
  case .changeRoot(let currentView):
    state.appState = currentView
  case .setNumberOfLaunches(let number):
    state.numberOfLaunches = number
  case .reset:
    state.appState = .login
  default:
    break
  }
}

