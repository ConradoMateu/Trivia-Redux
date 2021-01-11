//
//  BrandFont.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 6/1/21.
//

import Foundation
import SwiftUI

enum BrandFont: String {
  case primary = "CooperBlackStd"
  case title = "aAstroSpace"
}

enum TextType: CGFloat {
  case title = 60
  case titleMid = 45
  case title2 = 30
  case subTitle = 20
  case subTitle2 = 16
  case footnote = 14
}

extension Font {
    static func custom(_ font: BrandFont, size: TextType) -> Font {
      return Font.custom(font.rawValue, size: size.rawValue)
  }
}

