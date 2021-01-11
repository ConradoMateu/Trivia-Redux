//
//  LoginViewModel.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject{
  
  @Published var userOne: String = ""
  @Published var userTwo: String = ""

  lazy var userOneValidation: ValidationPublisher = {
      $userOne.nonEmptyValidator("Name of User One must be provided")
  }()
  
  lazy var userTwoValidation: ValidationPublisher = {
      $userTwo.nonEmptyValidator("Name of User Two must be provided")
  }()
  
  
  lazy var nonDuplicatedUsersValidation: ValidationPublisher = {
    ValidationPublishers.nonDuplicatedValidation(for: ($userOne,$userTwo), errorMessage: "Player One must be different from Player Two")
  }()
  
  
  lazy var allValidation: ValidationPublisher = {
      Publishers.CombineLatest3(
        userOneValidation,
        userTwoValidation,
        nonDuplicatedUsersValidation
      ).map { v1, v2, v3 in
          return [v1, v2, v3].allSatisfy { $0.isSuccess } ? .success : .failure(message: "")
      }.eraseToAnyPublisher()
  }()

}

