//
//  Trivial_iOSApp.swift
//  TriviaRedux
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
