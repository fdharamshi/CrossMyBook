//
//  SearchModel.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/4/22.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let msg: String
    let success: Bool
    let availableCopies: [SearchAvailableCopy]
    let books: [SearchBook]

    enum CodingKeys: String, CodingKey {
        case msg, success
        case availableCopies = "available_copies"
        case books = "Books"
    }
}

// MARK: - SearchAvailableCopy
struct SearchAvailableCopy: Codable, Identifiable {
    let title, copyOwner: String
    let copyID: Int
    let coverURL: String
    let author, isbn: String
    let bookID, status: Int
    let ownerProfile: String
    let rating: Rating
  
    var id: Int {
      copyID
    }

    enum CodingKeys: String, CodingKey {
        case title
        case copyOwner = "copy_owner"
        case ownerProfile = "owner_profile"
        case copyID = "copy_id"
        case coverURL = "cover_url"
        case author, isbn
        case bookID = "book_id"
        case status, rating
    }
}

// MARK: - SearchBook
struct SearchBook: Codable, Identifiable {
    let title: String
    let id: Int
    let coverURL: String
    let author, isbn: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case title, id
        case coverURL = "cover_url"
        case author, isbn, rating
    }
}

