//
//  ValidationPublishers.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import Combine

typealias ValidationErrorClosure = () -> String

typealias ValidationPublisher = AnyPublisher<Validation, Never>


class ValidationPublishers {

    // Validates whether a string property is non-empty.
    static func nonEmptyValidation(for publisher: Published<String>.Publisher,
                                   errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map { value in
            guard value.count > 0 else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }
  
  static func nonDuplicatedValidation(for publishers: (Published<String>.Publisher, Published<String>.Publisher),
                                 errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
      
    return Publishers.CombineLatest(publishers.0,publishers.1).map{ stringOne, stringTwo in
          guard stringOne != stringTwo else{
            return .failure(message: errorMessage())
          }
          return .success
        }
      .dropFirst()
      .eraseToAnyPublisher()
  }

}

