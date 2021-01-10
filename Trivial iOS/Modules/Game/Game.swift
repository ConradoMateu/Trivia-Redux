//
//  Game.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct Game: View {
  @EnvironmentObject var store: AppStore
  @ObservedObject var viewModel: GameViewModel = GameViewModel()
  var currentQuestion: Question {
    if !store.state.game.questions.isEmpty{
      return store.state.game.questions[store.state.game.currentQuestion]
    }else{
     return  Question.empty
    }
    
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
          
          ForEach(currentQuestion.shuffledAnswers, id: \.self) { item in
            Group{
              BrandButton(text: item, textColor: .brand_white, backgroundColor: .brand_blue, action: {
              self.store.dispatch(.game(action: .check(answer: item)))
                self.store.dispatch(.game(action: .next))
            }).onReceive(store.state.game.isCorrectAnswer, perform: { isCorrect in
              print("is Corret \(isCorrect)")
              
            })
            }
          }
        }
          Spacer()
        }
        
        
      }.padding([.leading,.trailing],10).backgroundConfig()
      .onAppear(){
        self.store.dispatch(.game(action: .fetch))
      }.onReceive(self.store.state.game.nextQuestion, perform: { newQuestion in
        print(newQuestion.flattenedAnswers)
        self.store.dispatch(.game(action: .save(currentQuestion: newQuestion)))
        viewModel.refresh(question: newQuestion)
        
        print(viewModel.answers.debugDescription)
      })
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
      Game().environmentObject(StoreGenerator.initialState)
    }
}
