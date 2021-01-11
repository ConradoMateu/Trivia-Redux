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
  var findCurrentAnserIndex: Int{
    for i in 0..<currentAnswers.count{
      if currentAnswers[i] == currentQuestion.correct_answer{
        print("\(currentAnswers[i]) == \(currentQuestion.correct_answer): \(i)")
        return i
      }
    }
    return -1
  }
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
              disableButtons = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
              currentAnswer = currentAnswers[i]
              if buttonStates[i] == .checking{
                if currentAnswers[i] == currentQuestion.correct_answer {
                  buttonStates[i] = .sucessful
                }else{
                  buttonStates[findCurrentAnserIndex] = .sucessful
                  buttonStates[i] = .failed
                }
              }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
              self.store.dispatch(.game(action: .check(answer: currentAnswers[i])))
            }
            })
          }
        }
          Spacer()
        }
        
        
      }.padding([.leading,.trailing],10)
      .backgroundConfig()

      .onAppear(){
        self.store.dispatch(.game(action: .fetch))
        for family in UIFont.familyNames {
          let sName: String = family as String
          print("family: \(sName)")

          for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
          }
        }
      }.onReceive(store.state.game.isCorrectAnswer){ isCorrect in
        DispatchQueue.main.async {
          self.store.dispatch(.game(action: .next))
        }
        
        buttonStates = [.normal, .normal, .normal, .normal]
        disableButtons = false
      }.onReceive(self.store.state.game.nextQuestion){ newQuestion in
        currentAnswers = newQuestion.flattenedAnswers
        currentQuestion = newQuestion
        currentAnswers.shuffle()
        DispatchQueue.main.async {
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


