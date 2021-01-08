//
//  AppAction.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

enum AppAction {
    case login(action: LoginAction)
    case settings(action: SettingsAction)
    case game(action: GameAction)
}
