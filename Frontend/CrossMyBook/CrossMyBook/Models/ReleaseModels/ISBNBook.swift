//
//  ISBNBook.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation
struct ISBNBook: Codable {
    let isbn, title: String
    let coverURL: String
    let author: String
    let bookID: Int
    let rating: Float

    enum CodingKeys: String, CodingKey {
        case isbn, title
        case coverURL = "cover_url"
        case author
        case bookID = "book_id"
        case rating
    }
}
