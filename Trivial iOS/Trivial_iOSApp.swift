//
//  Trivial_iOSApp.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 6/1/21.
//

import SwiftUI

let store = Store(reducer: reducer)

@main
struct Trivial_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            Login().environmentObject(store)
        }
    }
}


enum currentView {
  case Login
  case Game
  case EndGame
}
