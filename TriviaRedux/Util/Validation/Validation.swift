//
//  Validation.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

enum Validation {
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
