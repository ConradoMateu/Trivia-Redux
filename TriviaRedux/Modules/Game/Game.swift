//
//  Game.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct Game: View {
  @EnvironmentObject var store: AppStore
  
  var game: GameStateProtocol {
    store.state.game
  }
  @State var currentQuestion: Question = Question.empty
  
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
            .offset(x: store.state.game.playerOne.isCurrentTurn ? 5 : 0, y: 0)
          Spacer()
          BrandPlayerCounter(player: store.state.game.playerTwo)
            .offset(x: store.state.game.playerTwo.isCurrentTurn ? -5 : 0, y: 0)
        }
        
        Spacer()
        VStack(spacing: 10){
          Text(currentQuestion.question)
            .foregroundColor(.brand_white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .center)
            .padding([.leading,.trailing],20)
            .background(RoundedRectangle(cornerRadius: 10)
                          .foregroundColor(.brand_blue))
            .padding(.bottom,20)
          
          ForEach(0..<currentQuestion.shuffledAnswers.count) { i in
            
            BrandButton(text: currentAnswers[i], textColor: .brand_white, backgroundColor: buttonStates[i].color,isDisabled: disableButtons){
              
              DispatchQueue.main.async {
                self.store.dispatch(.game(action: .reduce(buttonIdx: i, for: .answered)))
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.store.dispatch(.game(action: .reduce(buttonIdx: i, for: .checked)))
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                self.store.dispatch(.game(action: .check(answer: currentAnswers[i])))
              }
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
  
  func checkColor(for state: ButtonState) -> Color {
    return state.color
  }
  
}

struct Game_Previews: PreviewProvider {
  static var previews: some View {
    Game().environmentObject(StoreGenerator.initialState)
  }
}





