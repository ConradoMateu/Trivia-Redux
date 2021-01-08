//
//  GameMiddleware.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 8/1/21.
//

import Foundation
import Combine

func gameMiddleware(gameStore: GameStoreProtocol) -> Middleware<AppState, AppAction> {
  
//  var settings = appSettings
  var newStore = gameStore
  return { state, action in
    switch action {
    
    case .game(action: .fetch):
      return gameStore.fetch()
      .map { AppAction.game(action: .fetchComplete(questions: $0 )) }
      .catch { (error: ApiError) -> Just<AppAction> in
          switch(error) {
          case .invalidResponse:
              return Just(AppAction.game(action: .fetchError(error: ApiError.invalidResponse)))
            
          case .statusCode(let code):
              return Just(AppAction.game(action: .fetchError(error: ApiError.statusCode(code))))

          default:
              return Just(AppAction.game(action: .fetchError(error: ApiError.unknown(error))))
          }
      }
      .eraseToAnyPublisher()
    case .game(action: .gameEnded):
      newStore.reset()
    case .game(action: .next(let question)):
      newStore.next(question: question)
    case .game(action: .check(let answer)):
      newStore.check(answer: answer)
    default:
      break
    }
    return Empty().eraseToAnyPublisher()
  }
}
