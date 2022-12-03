//
//  ReviewsModel.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/12/2.
//

import Foundation

struct ReviewsModel: Codable {
  let success: Bool
  let msg: String
  let reviews: [ReviewSummary]
}

struct ReviewSummary: Codable, Identifiable, Hashable {
  let id: Int
  let bookId: Int
  let bookTitle: String
  let bookAuthor: String
  let bookCover: String
  let content: String
  let date: String
  
  enum CodingKeys: String, CodingKey {
    case id, date, content
    case bookId = "book_id"
    case bookTitle = "book_title"
    case bookAuthor = "book_author"
    case bookCover = "book_cover"
  }
}
