//
//  TemporaryMainModel.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import Foundation

// MARK: - Welcome
struct TemporaryMainModel: Codable {
  let msg: String
      let success: Bool
      let allBooks, allCopies: [All]

      enum CodingKeys: String, CodingKey {
          case msg, success
          case allBooks = "all_books"
          case allCopies = "all_copies"
      }
  }

  // MARK: - All
  struct All: Codable, Identifiable {
    let id = UUID()
      let bookID: Int?
      let title: String
      let coverURL: String
      let author: String
      let copyID: Int?

      enum CodingKeys: String, CodingKey {
          case bookID = "book_id"
          case title
          case coverURL = "cover_url"
          case author
          case copyID = "copy_id"
      }
  }


