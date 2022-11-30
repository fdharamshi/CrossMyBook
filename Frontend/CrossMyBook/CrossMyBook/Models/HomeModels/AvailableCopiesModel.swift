//
//  AvailableCopiesModel.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/29.
//

import Foundation

struct AvailableCopiesModel: Codable {
  let success: Bool
  let msg: String
  let availableCopies: [Copy]
  
  enum CodingKeys: String, CodingKey {
    case success, msg
    case availableCopies = "available_copies"
  }
}

struct Copy: Codable, Identifiable {
  var id = UUID()
  var copyId: Int
  var title: String
  var author: String
  var rating: Double
  var coverUrl: String
  
  enum CodingKeys: String, CodingKey {
    case title, author, rating
    case copyId = "copy_id"
    case coverUrl = "cover_url"
  }
}

