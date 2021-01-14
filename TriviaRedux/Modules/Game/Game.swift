//
//  Game.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct Game: View {
  @EnvironmentObject var store: AppStore
  
  @State var currentQuestion: Question = Question.empty
  
  var game: GameStateProtocol {
    store.state.game
  }
  
  var currentAnswers: [String] {
    game.currentAnswers
  }
  
  var buttonStates: [ButtonState] {
    game.buttonStates
  }
  
  var disableButtons: Bool {
    game.disableButtons
  }
  
  var body: some View {
    VStack{
      if store.state.game.fetching {
        ProgressView("Loading...").brandStyle()
      }else{
        Spacer()
        HStack{
          BrandPlayerCounter(player: store.state.game.playerOne)
            .offset(x: game.playerOne.isCurrentTurn ? 5 : 0, y: 0)
          Spacer()
          BrandPlayerCounter(player: store.state.game.playerTwo)
            .offset(x: game.playerTwo.isCurrentTurn ? -5 : 0, y: 0)
        }
        Spacer()
        VStack(spacing: 10){
          QuestionText(question: currentQuestion.question)
          
          ForEach(0..<currentQuestion.shuffledAnswers.count) { i in
            BrandButton(text: currentAnswers[i], textColor: .brand_white, backgroundColor: buttonStates[i].color,isDisabled: disableButtons){
              onClick(for: i)
            }
          }
        }
        Spacer()
      }
    }.padding([.leading,.trailing],10)
    .backgroundConfig()
    .onAppear(){
      self.store.dispatch(.game(action: .fetch))
    }.onReceive(store.state.game.isCorrectAnswer){ isCorrect in
      DispatchQueue.main.async {
        self.store.dispatch(.game(action: .next))
      }
      
    }.onReceive(self.store.state.game.nextQuestion){ newQuestion in
      currentQuestion = newQuestion
      DispatchQueue.main.async {
        self.store.dispatch(.game(action: .reduce(buttonIdx: -1, for: .notAnswered)))
        self.store.dispatch(.game(action: .save(currentQuestion: newQuestion)))
      }
    }.onReceive(self.store.state.game.endGame){ isGameEnded in
      if isGameEnded {
        DispatchQueue.main.async {
          store.dispatch(.game(action: .gameEnded))
        }
      }
    }
  }
  
  func onClick(for index: Int) {
    DispatchQueue.main.async {
      self.store.dispatch(.game(action: .reduce(buttonIdx: index, for: .answered)))
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
      self.store.dispatch(.game(action: .reduce(buttonIdx: index, for: .checked)))
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
      self.store.dispatch(.game(action: .check(answer: currentAnswers[index])))
    }
  }
  
}

struct Game_Previews: PreviewProvider {
  static var previews: some View {
    Game().environmentObject(StoreGenerator.initialState)
  }
}





