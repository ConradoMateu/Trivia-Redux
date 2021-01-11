//
//  ContentView.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: AppStore
    var body: some View {
      VStack{
        switch store.state.settings.appState{
        case .login:
          Login().environmentObject(store)
        case .game:
          Game().environmentObject(store)
        case .endGame:
          WinnerView().environmentObject(store)
        }
      }
    }
}


