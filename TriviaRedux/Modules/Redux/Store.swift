//
//  Store.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import Combine
import SwiftUI

typealias Reducer = (AppState, Action) -> AppState

class Store: ObservableObject {
  
  var reducer: Reducer
  @Published private (set) var state: AppState
  
  init(reducer: @escaping Reducer, state: AppState = AppState()) {
    self.reducer = reducer
    self.state = state
  }
  
  func dispatch(action: Action) {
    DispatchQueue.main.async {
      self.state = self.reducer(self.state, action)
      
    }
  }
  
}

struct AppState {
  var counter = 0
  var appState: currentView = .login
  var questions: [Question] = [Question]()
  var currentQuestion: Question? = nil
  var userOne: String = ""
  var userTwo: String = ""
}


