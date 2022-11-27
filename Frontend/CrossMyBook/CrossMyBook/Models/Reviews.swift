//
//  Reviews.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import Foundation
struct Reviews: Decodable {
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case reviews;
    }

}

struct Review: Decodable {
    let reviewId: Int
    let userId: Int
    let userName: String
    let userAvatar: String
    let bookId: Int
    let bookTitle: String
    let bookAuthor: String
    let bookCover: String
    let content: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case reviewId = "id"
        case userId = "user_id"
        case userName = "user_name"
        case userAvatar = "user_avatar"
        case bookId = "book_id"
        case bookTitle = "book_title"
        case bookAuthor = "book_author"
        case bookCover = "book_cover"
        case content
        case date
    }
}
