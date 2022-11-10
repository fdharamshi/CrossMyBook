//
//  Profile.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/10.
//

import Foundation

struct Profile: Codable {
  let success: Bool
  let msg: String
  let firstName: String
  let lastName: String
  let email: String
  let userID: Int
  let profileUrl: String
  let reviewNumber: Int
  
  enum CodingKeys: String, CodingKey {
    case success
    case msg
    case firstName = "first_name"
    case lastName = "last_name"
    case email
    case userID = "user_id"
    case profileUrl = "profile_url"
    case reviewNumber = "review_number"
  }
}
