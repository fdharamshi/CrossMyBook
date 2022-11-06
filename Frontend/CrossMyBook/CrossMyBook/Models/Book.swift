//
//  Book.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import Foundation

struct Book : Decodable {
  let bookId: Int
  let coverURL: String
  let title: String
  let author: String
  let description: String
  let rating: Float
  let copies: [BDCopy]
//  let reviews: [BDReview]

  enum CodingKeys : String, CodingKey {
    case bookId = "book_id"
    case coverURL = "cover_url"
    case title
    case author = "authors"
    case description
    case rating
    case copies
//    case reviews
  }
}
