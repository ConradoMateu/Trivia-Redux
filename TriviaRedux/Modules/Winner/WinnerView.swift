//
//  WinnerView.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 11/1/21.
//

import SwiftUI

struct WinnerView: View {
  @EnvironmentObject var store: AppStore
  
  var winner: Player {
    store.state.game.playerOne
  }
  
  var winnerTwo: Player{
    store.state.game.playerTwo
  }
  
  var drawGame: Bool {
    winner.score == winnerTwo.score
  }
  
  var isPlayerOneWinner:Bool {
    winner.score > winnerTwo.score
  }
  
  var winnerText: String {
    drawGame ? "Draw" : "Winner"
  }

    var body: some View {
      ZStack{
        Image("confetti").resizable().scaledToFill()
        VStack(spacing: 50){
          Text(winnerText)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 10)
            .font(.custom(.title, size: .titleMid))
          
          if drawGame {
            BrandPlayerCounter(player: winner)
              .scaleEffect(1.5)
            BrandPlayerCounter(player: winnerTwo)
              .scaleEffect(1.5)
          }else if isPlayerOneWinner {
            BrandPlayerCounter(player: winner)
              .scaleEffect(1.5)
          }else {
            BrandPlayerCounter(player: winnerTwo)
              .scaleEffect(1.5)
          }
        }
      }.backgroundConfig()
      .onAppear(){
        DispatchQueue.main.async {
          self.store.dispatch(.game(action: .getUsers))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
          store.dispatch(.game(action: .reset))
          store.dispatch(.settings(action: .reset))
        }
      }
    }
}

//struct WinnerView_Previews: PreviewProvider {
//    static var previews: some View {
//      WinnerView(winner: Player.generate(name: "Alfred"), winnerTwo: Player.generate(name: "Susan")).environmentObject(StoreGenerator.initialState)
//}
//}
