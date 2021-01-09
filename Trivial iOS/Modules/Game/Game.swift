//
//  Game.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct Game: View {
  @EnvironmentObject var store: AppStore
  
  var currentQuestion: Question {
    if !store.state.game.questions.isEmpty{
      return store.state.game.questions[store.state.game.currentQuestion]
    }else{
     return  Question.empty
    }
    
  }
    var body: some View {
      VStack{
//        if store.state.game.fetching {
//        ProgressView("Loading...").brandStyle()
//        }else{
        Spacer()
        HStack{
          HStack{
            Image("avatar-female")
              .resizable()
              .frame(width: 50, height: 50)
              .foregroundColor(.brand_white)
            VStack{
//              Text(store.state.login.userOne)
              Text("Player 1")
              Text("Score: 5")
            }
          }.padding().background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.brand_blue))
          Spacer()
          HStack{
            Image("avatar-female")
              .resizable()
              .frame(width: 50, height: 50)
              .foregroundColor(.brand_white)
            VStack{
//              Text(store.state.login.userOne)
              Text("Player 2")
              Text("Score: 5")
            }
          }.padding().background(RoundedRectangle(cornerRadius: 10)
                                  .foregroundColor(.brand_green)).scaleEffect(1.05).offset(x: -5.0, y: 0)
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
          BrandButton(text: currentQuestion.correct_answer, textColor: .brand_white, backgroundColor: .brand_blue, action: {})
          BrandButton(text: currentQuestion.correct_answer, textColor: .brand_white, backgroundColor: .brand_blue, action: {})
          BrandButton(text: currentQuestion.correct_answer, textColor: .brand_white, backgroundColor: .brand_blue, action: {})
          BrandButton(text: currentQuestion.correct_answer, textColor: .brand_white, backgroundColor: .brand_blue, action: {})
        }
        
//        }
        Spacer()
        
      }.padding([.leading,.trailing],10).backgroundConfig()
      .onAppear(){
        self.store.dispatch(.game(action: .fetch))
      }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
      Game().environmentObject(StoreGenerator.initialState)
    }
}
