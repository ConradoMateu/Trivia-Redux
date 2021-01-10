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
  @State var currentAnswer: String = ""
  @State var buttonStates: [ButtonState]  = [.normal, .normal, .normal, .normal]
  @State var currentAnswers: [String] = ["","","",""]
  @State var disableButtons: Bool = false
  @State var currentQuestion: Question = Question.empty
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
            
            BrandButton(text: currentAnswers[i], textColor: .brand_white, backgroundColor: buttonStates[i].color,isDisabled: disableButtons,action: {
              currentAnswer = currentAnswers[i]
            buttonStates[i] = .checking
              
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
              currentAnswer = currentAnswers[i]
              
              buttonStates[findCurrentAnserIndex()] = .sucessful
//              disableButtons = true
              
              if buttonStates[i] == .checking{
                if currentAnswers[i] == currentQuestion.correct_answer {
                  buttonStates[i] = .sucessful
                }else{
                  
                  buttonStates[i] = .failed
                }
                
              }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
             
              self.store.dispatch(.game(action: .check(answer: currentAnswers[i])))
            }
            

            
            })
                
            .disabled(disableButtons)
            
          }
        }
          Spacer()
        }
        
        
      }.padding([.leading,.trailing],10).backgroundConfig()
      .onReceive(store.state.game.isCorrectAnswer, perform: { isCorrect in
        print("is Corret \(isCorrect)")
        self.store.dispatch(.game(action: .next))
        buttonStates = [.normal, .normal, .normal, .normal]
        disableButtons = false
      })
      .onAppear(){
        self.store.dispatch(.game(action: .fetch))
      }.onReceive(self.store.state.game.nextQuestion, perform: { newQuestion in
        print(newQuestion.flattenedAnswers)
        currentAnswers = newQuestion.flattenedAnswers
        currentQuestion = newQuestion
        currentAnswers.shuffle()
        
        
        self.store.dispatch(.game(action: .save(currentQuestion: newQuestion)))
        viewModel.refresh(question: newQuestion)
        
        //Si no esta empty las questions
        //Delay 3 secods
        
        //change color
        
        print(viewModel.answers.debugDescription)
      })
    }
  
  func checkColor(for state: ButtonState) -> Color {
      return state.color
  }
  func findCurrentAnserIndex() -> Int{
    
    for i in 0..<currentAnswers.count{
      if currentAnswers[i] == currentQuestion.correct_answer{
        print("\(currentAnswers[i]) == \(currentQuestion.correct_answer): \(i)")
        return i
      }
    }
    return -1
  }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
      Game().environmentObject(StoreGenerator.initialState)
    }
}


enum ButtonState {
  case normal, checking, failed, sucessful
  

}

extension ButtonState {
   var color:Color {
    switch self{
    case .normal:
      return .brand_blue
    case .checking:
      return .yellow
    case .sucessful:
    return .brand_green
    case .failed:
      return .brand_red
    }
  }
}


