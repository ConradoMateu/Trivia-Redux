//
//  ContentView.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 6/1/21.
//

import SwiftUI


struct Login: View {
  @EnvironmentObject var store: Store
  
  @State var userOne: String = ""
  @State var userTwo: String = ""
  
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
            BrandTextField(text: self.$userOne)
          }
          VStack(alignment: .leading){
            Text("Nickname User 2")
              .foregroundColor(.brand_white)
            BrandTextField(text: self.$userTwo)
          }
          Spacer()
          BrandButton(text: "Enter", textColor: .brand_white, backgroundColor: .brand_green, action: {
              self.store.dispatch(action: SetLoginAction(users: (userOne,userTwo)))
          })
        }
        .padding()
        .frame(minHeight: 0, idealHeight: 100, maxHeight: 400)
        
      }.background(RoundedRectangle(cornerRadius: 10).foregroundColor(.brand_blue))
      .padding([.leading,.trailing], 20)
      .padding(.top,-padding)
      Spacer()
    }.backgroundConfig()
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Login().environmentObject(Store(reducer: reducer))
  }
}
