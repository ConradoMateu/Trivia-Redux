//
//  LoginReducer.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation

func loginReducer(state: inout LoginStateProtocol, action: LoginAction) -> Void {
    switch action {

    case .save(let userOne,let userTwo):
      state.userOne = userOne
      state.userTwo = userTwo

    }

}
