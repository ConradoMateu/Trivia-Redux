//
//  View Modifiers.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 6/1/21.
//

import Foundation
import SwiftUI

struct BackgroundConfig: ViewModifier {
    func body(content: Content) -> some View {
        content
          .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
          .background(Color.brand_background)
          .edgesIgnoringSafeArea(.all)
          
    }
}

struct BrandProgressViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
          .padding(20)
          .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.brand_blue))
          .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
          .foregroundColor(.brand_white)
          .scaleEffect(1.5)
    }
}

extension View {
    func backgroundConfig() -> some View {
        modifier(BackgroundConfig())
    }
}

extension ProgressView{
  func brandStyle() -> some View {
      modifier(BrandProgressViewStyle())
  }
}


