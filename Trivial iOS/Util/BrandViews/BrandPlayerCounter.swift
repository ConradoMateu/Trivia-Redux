//
//  BrandPlayerCounter.swift
//  Trivial iOS
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
        VStack{
//              Text(store.state.login.userOne)
          Text(player.name)
          Text("Score: \(player.score)")
        }
      }.padding().background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.brand_blue))
    }
}

struct BrandPlayerCounter_Previews: PreviewProvider {
    static var previews: some View {
      BrandPlayerCounter(player: Player.generate(name: "Player"))
    }
}
