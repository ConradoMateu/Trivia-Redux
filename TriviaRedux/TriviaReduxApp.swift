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
  

  
  var body: some Scene {
    
    WindowGroup {
      ContentView().environmentObject(StoreGenerator.initialState)
    }
  }
}


enum currentView: String, Codable {
  case login
  case game
  case endGame
}
