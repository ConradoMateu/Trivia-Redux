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
  
    init(questions: (String,String)) {
      self.userOne = questions.0
      self.userTwo = questions.1
    }
}
