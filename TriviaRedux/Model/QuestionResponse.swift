//
//  QuestionResponse.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation


struct QuestionResponse: Codable {
  let results: [Question]
  let response_code: Int

  enum CodingKeys: String, CodingKey {
    case results
    case response_code
  }

}
