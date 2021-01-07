//
//  View Modifiers.swift
//  Trivial iOS
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



extension View {
    func backgroundConfig() -> some View {
        modifier(BackgroundConfig())
    }
}


