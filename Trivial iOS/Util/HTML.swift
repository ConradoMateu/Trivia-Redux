//
//  HTML.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 11/1/21.
//


import Foundation

extension String {
    var htmlToString: String {
      guard let _ = htmlToNSAttributedString?.string else {
        return self
      }
        return htmlToNSAttributedString!.string
    }

    var htmlToNSAttributedString: NSAttributedString? {
        if let data = data(using: .utf8) {
            return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: Encoding.utf8], documentAttributes: nil)

        }
        return nil
    }
}
