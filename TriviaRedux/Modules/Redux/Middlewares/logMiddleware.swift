//
//  logMiddleware.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine
func logMiddleware() -> Middleware<AppState, AppAction> {

    return { state, action in
//        print("Triggered action: \(action)")
        return Empty().eraseToAnyPublisher()
    }


}
