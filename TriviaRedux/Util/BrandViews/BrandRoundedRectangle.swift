//
//  BrandRoundedRectangle.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 6/1/21.
//

import Foundation
import SwiftUI
struct BrandRoundedRectangle: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 25, style: .continuous)
      .fill(Color.brand_blue)
      .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
  }
}

