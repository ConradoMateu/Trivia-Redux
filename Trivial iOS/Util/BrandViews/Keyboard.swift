//
//  Keyboard.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 10/1/21.
//

import Foundation

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
