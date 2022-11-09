//
//  Msg.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation
struct Msg: Codable {
  let msg: String
  let success: Bool
  
  enum CodingKeys: String, CodingKey {
    case success, msg
  }
}
