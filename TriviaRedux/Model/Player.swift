//
//  Player.swift
//  TriviaRedux
//
//  Created by Conrado Mateu on 9/1/21.
//

import Foundation


struct Player: Codable {
  let name: String
  var score: Int
  let avatarImage: String
  var isCurrentTurn: Bool
  
  enum CodingKeys: String, CodingKey {
    case name
    case score
    case avatarImage
    case isCurrentTurn
  }
}


extension Player{
  private static var randomAvatar: String {
    AvatarImage.allCases.randomElement()!.rawValue
  }
  static var empty: Player {
    Player(name: "Player",
           score: 0,
           avatarImage: randomAvatar,
           isCurrentTurn: false)
  }
  static func generate(name: String, currentTurn: Bool = false) -> Player {
    return Player(name: name,
                  score: 0,
                  avatarImage: randomAvatar,
                  isCurrentTurn: currentTurn)
  }
  static func generate(name: String, currentTurn: Bool = false,image: AvatarImage) -> Player {
    return Player(name: name,
                  score: 0,
                  avatarImage: image.rawValue,
                  isCurrentTurn: currentTurn)
  }
}



enum AvatarImage:String, CaseIterable {
  case einstein
  case heisenberg
  case female
  case male
  case worker
}
