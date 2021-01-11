//
//  Question.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import HTMLEntities
struct Question: Codable {
  let incorrect_answers: [String]
  let correct_answer: String
  let type: String
  let category: String
  let difficulty: String
  let question: String

  enum CodingKeys: String, CodingKey {
    case incorrect_answers
    case correct_answer
    case type
    case category
    case difficulty
    case question
  }

}

extension Question {
  static var empty: Question {
  Question(incorrect_answers: [], correct_answer: "", type: "", category: "", difficulty: "", question: "")
  }
  
  var flattenedAnswers: [String] {
    return [self.correct_answer] + self.incorrect_answers
  }
  
  var shuffledAnswers: [String] {
    return self.flattenedAnswers.shuffled()
  }
  
  var decodeHTML: Question{
    let decodedQuestion: Question
    let decodedWrongAnswers = self.incorrect_answers.map{$0.htmlUnescape()}
    let decodedCorrectAnswer = self.correct_answer.htmlUnescape()
    let decodedQ = self.question.htmlUnescape()
    
    return Question(incorrect_answers: decodedWrongAnswers, correct_answer: decodedCorrectAnswer, type: self.type, category: self.category, difficulty: self.difficulty, question: decodedQ)
  }


}




