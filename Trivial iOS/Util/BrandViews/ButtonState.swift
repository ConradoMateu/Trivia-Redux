//
//  ButtonState.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 11/1/21.
//

import Foundation
import SwiftUI

enum ButtonState {
  case normal, checking, failed, sucessful
}

extension ButtonState {
   var color:Color {
    switch self{
    case .normal:
      return .brand_blue
    case .checking:
      return .yellow
    case .sucessful:
    return .brand_green
    case .failed:
      return .brand_red
    }
  }
  
  static var notAnsweredState: [ButtonState] {
    return [.normal,.normal,.normal,.normal]
  }
}
