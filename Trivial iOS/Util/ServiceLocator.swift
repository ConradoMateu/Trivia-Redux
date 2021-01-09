//
//  ServiceLocator.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation


struct StoreGenerator {
  static var initialState: AppStore {AppStore(initialState: .init(
                                              settings: SettingsState(),
                                              game: GameState(), login: LoginState()),
                                            reducer: appReducer,
                                            middlewares: [
                                              gameMiddleware(gameStore: GameStore()),
                                              loginMiddleware(loginStore: LoginStore()),
                                              settingsMiddleware(appSettings: AppSettingsStore()),
                                              logMiddleware()
                                            ])}
}
