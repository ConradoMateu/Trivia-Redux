//
//  LoginAction.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation


struct SetLoginAction: Action {
    let userOne: String
    let userTwo: String
  
    init(users: (String,String)) {
      self.userOne = users.0
      self.userTwo = users.1
    }
}
