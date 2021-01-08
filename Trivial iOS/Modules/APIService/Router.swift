//
//  Router.swift
//  Trivial iOS
//
//  Created by Conrado Mateu on 7/1/21.
//

import Foundation

//
//  APIService.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
//


import Foundation

enum Router: Equatable {
  case questions
  
  var url: String {scheme+host}
  var scheme: String {API.scheme}
  var host: String {API.URL}
  
  
  var path: String {
    switch self {
    case .questions:
      return "/api.php"
      
    }
  }
  
  var parameters: [URLQueryItem]? {
    switch self {
    case .questions:
      return [URLQueryItem(name: "type", value: "multiple"),
              URLQueryItem(name: "amount", value: CONSTANTS.MAX_QUESTIONS_IN_CHACHE),
              URLQueryItem(name: "language", value: "en-US")]
    }
  }
  
  var method: String {
    switch self {
    case .questions:
      return "GET"
    }
  }
}

struct API {
  static var schemeURL: String {scheme + "://" + URL}
  static var scheme: String {return "https"}
  static var URL: String {
    "opentdb.com"
  }
}


