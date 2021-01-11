//
//  BrandPlayerCounter.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 9/1/21.
//

import SwiftUI

struct BrandPlayerCounter: View {
  let player: Player
  
    var body: some View {
      HStack{
        Image(player.avatarImage)
          .resizable()
          .frame(width: 50, height: 50)
          .foregroundColor(.brand_white)
        VStack(alignment:.leading){
          Text(player.name).foregroundColor(.white)
          Text("Score: \(player.score)").font(.custom(.primary, size: .footnote)).foregroundColor(.white)
        }
      }.padding().background(RoundedRectangle(cornerRadius: 10)
                              .foregroundColor(player.isCurrentTurn ? .brand_green : .brand_blue))
      .scaleEffect(player.isCurrentTurn ? 1.05 : 1)
      
    }
}

struct BrandPlayerCounter_Previews: PreviewProvider {
    static var previews: some View {
      VStack{
        BrandPlayerCounter(player: Player.generate(name: "Player", currentTurn: false))
        BrandPlayerCounter(player: Player.generate(name: "Player", currentTurn: true))
      }
      
    }
}
