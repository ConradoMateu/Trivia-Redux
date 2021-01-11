//
//  SettingsStore.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation

protocol AppSettingsStoreProtocol {
  var rootView: currentView { get set }
  var numberOfLaunches: Int { get set }
}

struct AppSettingsStore: AppSettingsStoreProtocol {

  @Storage(key: AppSettingsKeys.rootView.rawValue, defaultValue: .login)
  var rootView: currentView
  
  @Storage(key: AppSettingsKeys.numberOfLaunches.rawValue, defaultValue: 0)
  var numberOfLaunches: Int

}
