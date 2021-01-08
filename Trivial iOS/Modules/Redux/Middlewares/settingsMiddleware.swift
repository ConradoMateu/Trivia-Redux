//
//  settingsMiddleware.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine

func settingsMiddleware(appSettings: AppSettingsStoreProtocol) -> Middleware<AppState, AppAction> {
  
  var settings = appSettings
  return { state, action in
    switch action {
    
    case .settings(action: SettingsAction.changeRoot(let view)):
      settings.rootView = view
    case .settings(action: .setNumberOfLaunches(let launches)):
      settings.numberOfLaunches = launches
      
    default:
      break
      
    }
    return Empty().eraseToAnyPublisher()
  }
}




