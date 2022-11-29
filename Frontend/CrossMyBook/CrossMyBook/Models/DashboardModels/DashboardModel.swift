//
//  DashboardModel.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/25.
//

import Foundation

struct DashboardModel: Codable {
  var currentBooks: [DashboardBooks]
  var historyBooks: [DashboardBooks]
  
  enum CodingKeys: String, CodingKey {
    case currentBooks = "current_books"
    case historyBooks = "history_books"
  }
}

struct DashboardBooks: Codable, Identifiable {
  var id = UUID()
  var bookId: Int
  var copyId: Int
  var title: String
  var author: String
  var rating: Double
  var coverUrl: String
  
  enum CodingKeys: String, CodingKey {
    case title, author, rating
    case bookId = "book_id"
    case copyId = "copy_id"
    case coverUrl = "cover_url"
  }
}
