//
//  Request.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/8.
//

import Foundation

struct RequestModel {
  var userID: Int = 0
  var copyID: Int = 0
  var listingID: Int = 0
  var lat: Double = 0
  var lon: Double = 0
  var note: String = ""
  
  enum CodingKeys: String, CodingKey {
    case userID = "user_id"
    case copyID = "copy_id"
    case listingID = "listing_id"
    case lat
    case lon
    case note
  }
}
