//
//  GameViewModel.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import SwiftUI
import Combine

class GameViewModel: ObservableObject {

  @Published var answers: [Answer] = Answer.initialize
  
  func refresh(question: Question) {
    let shuffledAnswers = question.shuffledAnswers
    var res: [Answer] = [Answer]()
    for i in 0..<shuffledAnswers.count {
      res.append(Answer(id: i, answer: shuffledAnswers[i]))
      answers[i].answer = shuffledAnswers[i]
    }
    self.objectWillChange.send()
  }
  
  
}


struct Answer {
  
  var id: Int
  var answer: String
  
  init(id: Int, answer: String) {
    self.id = id
    self.answer = answer
  }
}

extension Answer {
  static var initialize: [Answer] {
    [Answer(id: 0, answer: "dasd"),
     Answer(id: 1, answer: "dasd"),
     Answer(id: 2, answer: "ddd"),
     Answer(id: 3, answer: "dd")]
  }
  
}


