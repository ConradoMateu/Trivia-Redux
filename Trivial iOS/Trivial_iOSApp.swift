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
  @State var appState: currentView = .login
    var body: some Scene {
      
        WindowGroup {
          VStack{
            switch appState{
            case .login:
              Login().environmentObject(store)
            case .game:
              Text("dasdsa").foregroundColor(Color.white)
            case .endGame:
              EmptyView()
            }
          }.onReceive(store.objectWillChange, perform: {
              print("AppState \(store.state.appState)")
            DispatchQueue.main.async {
              self.appState = store.state.appState
            }
          })
        }
    }
}


enum currentView {
  case login
  case game
  case endGame
}
