//
//  ContentView.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 6/1/21.
//

import SwiftUI


struct Login: View {
  @EnvironmentObject var store: AppStore
  
  @ObservedObject var viewModel:LoginViewModel = LoginViewModel()
  @State var isButtonDisabled = true

  var padding: CGFloat = 60
  
  var body: some View {
    VStack{
      Text("Trivial iOS")
        .foregroundColor(.brand_white)
        .font(.custom(.primary, size: .title2))
        .padding(.top,padding)
      Spacer()
      VStack{
        VStack(alignment:.leading, spacing: 20){
          VStack(alignment: .leading){
            Text("Nickname User 1")
              .foregroundColor(.brand_white)
            BrandTextField(text: $viewModel.userOne)
              .validation(viewModel.userOneValidation)
          }
          VStack(alignment: .leading){
            Text("Nickname User 2")
              .foregroundColor(.brand_white)
            BrandTextField(text: $viewModel.userTwo)
              .validation(viewModel.userTwoValidation)
              .validation(viewModel.nonDuplicatedUsersValidation)
          }
          Spacer()
          BrandButton(text: "Enter", textColor: .brand_white, backgroundColor: .brand_green, action: {
            login()
          }).disabled(isButtonDisabled)
          .opacity(isButtonDisabled ? 0.4 : 1)
        }
        .padding()
        .frame(minHeight: 0, idealHeight: 100, maxHeight: 400)
        
      }.background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.brand_blue))
      .padding([.leading,.trailing], 20)
      .padding(.top,-padding)
      Spacer()
    }.backgroundConfig()
    .onReceive(viewModel.allValidation, perform: {validation in self.isButtonDisabled = !validation.isSuccess})
    
  }
  
  func login() {
    self.store.dispatch(AppAction.game(action: .login(playerOne: Player.generate(name: viewModel.userOne, currentTurn: true), playerTwo: Player.generate(name: viewModel.userTwo, currentTurn: false))))
    self.store.dispatch(AppAction.settings(action: .changeRoot(toView: .game)))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Login().environmentObject(StoreGenerator.initialState)
  }
}
