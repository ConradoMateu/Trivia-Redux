//
//  SettingsAction.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

enum SettingsAction{
  case changeRoot(toView: currentView)
  case setNumberOfLaunches(number: Int)
  case reset
  case changeTurn
}
