//
//  Trivial_iOSApp.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 6/1/21.
//

import SwiftUI
import Combine

@main
struct Trivial_iOSApp: App {
  
  private  let store = AppStore(initialState: .init(
                                  settings: SettingsState(),
                                  game: GameState(), login: LoginState()),
                                reducer: appReducer,
                                middlewares: [
                                  gameMiddleware(gameStore: GameStore()),
                                  loginMiddleware(loginStore: LoginStore()),
                                  settingsMiddleware(appSettings: AppSettingsStore())
                                ]
  )
  
  
  var body: some Scene {
    
    WindowGroup {
      ContentView().environmentObject(store)
    }
  }
}


enum currentView: String, Codable {
  case login
  case game
  case endGame
}
