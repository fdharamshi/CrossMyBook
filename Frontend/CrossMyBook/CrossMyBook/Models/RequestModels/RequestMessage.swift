//
//  RequestMessage.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/9.
//

import Foundation

class RequestMessage: Codable {
  let msg: String
  let success: Bool
  let requestID: Int
  
  enum CodingKeys: String, CodingKey {
    case msg
    case success
    case requestID = "request_id"
  }
}
