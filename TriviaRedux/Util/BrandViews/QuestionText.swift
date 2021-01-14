//
//  QuestionText.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 14/1/21.
//

import SwiftUI

struct QuestionText: View {
  var question: String
    var body: some View {
      Text(question)
                  .foregroundColor(.brand_white)
                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .center)
                  .padding([.leading,.trailing],20)
                  .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.brand_blue))
                  .padding(.bottom,20)
    }
}

struct QuestionText_Previews: PreviewProvider {
    static var previews: some View {
      QuestionText(question: "Test Question")
    }
}
