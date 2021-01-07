//
//  Question.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

struct Question: Codable {
  let incorrect_answers: [String]?
  let correct_answer: String?
  let type: String?
  let category: String?
  let difficulty: String?
  let question: String?

  enum CodingKeys: String, CodingKey {
    case incorrect_answers
    case correct_answer
    case type
    case category
    case difficulty
    case question
  }

}

