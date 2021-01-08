//
//  Game.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import SwiftUI

struct Game: View {
  @EnvironmentObject var store: AppStore
    var body: some View {
      VStack{
        BrandButton(text: "Answer1", textColor: .brand_white, backgroundColor: .brand_blue, action: {})
      }.backgroundConfig()
      .onAppear(){
        self.store.dispatch(.game(action: .fetch))
        print(store.state.login.userTwo)
      }.onReceive(self.store.$state, perform: { _ in
        print(self.store.state.game.questions)
      })
        
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
