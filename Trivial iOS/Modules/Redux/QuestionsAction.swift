//
//  Questions.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Combine

struct SetQuestionsAction: Action {
    let questions: [Question]
  
    
    init(questions: [Question]) {
        self.questions = questions
    }
}

struct GetQuestionsAction: Action {
  var request: AnyCancellable?
  
  func getQuestions()  -> AnyPublisher<QuestionResponse, ApiError>{
    return ServiceLayer.shared.run(Router.questions)
  }
  
  func execute() -> AnyCancellable {
    return self.getQuestions().on(queue: .main)
    .on(success: { data in
      store.dispatch(action: SetQuestionsAction(questions: data.results))
    }, failure: { error in
      print(error)
    })
  }

    init() {
      request = execute()
    }
}
