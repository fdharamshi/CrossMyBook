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
    let allBooks: [AllBook]
    let allListings: [AllListing]

    enum CodingKeys: String, CodingKey {
        case msg, success
        case allBooks = "all_books"
        case allListings = "all_listings"
    }
}

// MARK: - AllBook
struct AllBook: Codable, Identifiable {
   let id = UUID()
    let bookID: Int
    let title: String
    let coverURL: String
    let author: String

    enum CodingKeys: String, CodingKey {
        case bookID = "book_id"
        case title
        case coverURL = "cover_url"
        case author
    }
}

// MARK: - AllListing
struct AllListing: Codable, Identifiable {
    var id = UUID()
  
    let listingID, status: Int
    let title: String
    let coverURL: String
    let author: String

    enum CodingKeys: String, CodingKey {
        case listingID = "listing_id"
        case status, title
        case coverURL = "cover_url"
        case author
    }
}

