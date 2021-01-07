//
//  BrandField.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 6/1/21.
//

import Foundation
import SwiftUI


struct BrandField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}


struct BrandTextField: View {
    @Binding var text: String

    var body: some View {
      BrandField(placeholder: Text("Insert text here...")
                    .font(.custom(.primary, size: .subTitle2))
                    .foregroundColor(.brand_white), text: $text)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.brand_background))
                    .foregroundColor(Color.white)
    }
}
