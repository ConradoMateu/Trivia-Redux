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
      return gameStore.fetch().subscribe(on: DispatchQueue.main)
        .map {
          AppAction.game(action: .fetchComplete(questions: $0.map{$0.decodeHTML} ))
        }
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
    case .game(action: .reset):
      return Just(newStore.reset()).map{
        AppAction.settings(action: .reset)
      }.map{
        AppAction.settings(action: .changeRoot(toView: .login))
      }
      .eraseToAnyPublisher()
    case .game(action: .gameEnded):
      newStore.playerOne.isCurrentTurn = false
      newStore.playerTwo.isCurrentTurn = false
      return Just(AppAction.settings(action: .changeRoot(toView: .endGame))).eraseToAnyPublisher()
    case .game(action: .save(let question)):
      newStore.currentQuestion = question
    case .game(action: .check(let answer)):
      return gameStore.check(answer: answer)
        .map{ isCorrect in
          AppAction.game(action: .checkedAnswer(isCorrect: isCorrect))
        }.eraseToAnyPublisher()
    case .game(action: .login(let playerOne,let playerTwo)):
      newStore.playerOne = playerOne
      newStore.playerTwo = playerTwo
    case .game(action: .getUsers):
      let userOne = gameStore.playerOne
      let userTwo = gameStore.playerTwo
      return Just(AppAction.game(action: .refreshGame(playerOne: userOne, playerTwo: userTwo))).eraseToAnyPublisher()
    case .game(action: .checkedAnswer(_)):
      newStore.playerOne.isCurrentTurn = !newStore.playerOne.isCurrentTurn
      newStore.playerTwo.isCurrentTurn = !newStore.playerTwo.isCurrentTurn
      return Just(AppAction.game(action: .refreshGame(playerOne: gameStore.playerOne, playerTwo: gameStore.playerTwo))).eraseToAnyPublisher()
      
      
    default:
      break
    }
    return Empty().eraseToAnyPublisher()
  }
}
