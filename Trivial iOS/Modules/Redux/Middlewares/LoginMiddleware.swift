//
//  LoginMiddleware.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine

func loginMiddleware(loginStore: LoginStoreProtocol) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
        
        
            case .login(action: .save(let userOne,let userTwo)):
              
              Just(AppAction.login(action: .save(userOne: userOne,userTwo: userTwo)))
              Just(AppAction.settings(action: .changeRoot(toView: .game)))
            default:
                break

        }
        return Empty().eraseToAnyPublisher()
    }
}

