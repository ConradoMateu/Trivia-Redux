//
//  BrandButton.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation
import SwiftUI

struct BrandButton: View {
  var text: String
  var textColor: Color
  var backgroundColor: Color
  var isDisabled: Bool
  var action: () -> ()
  
  init(text: String, textColor: Color, backgroundColor: Color,isDisabled: Bool = false,action: @escaping () -> ()) {
    self.text = text
    self.textColor = textColor
    self.backgroundColor = backgroundColor
    self.isDisabled = isDisabled
    self.action = action
  }
 
  
  var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(text)
        .bold()
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, maxHeight: 60, alignment: .center)
        .foregroundColor(textColor).background(RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(backgroundColor))
      
    }).disabled(isDisabled)
  }
}


