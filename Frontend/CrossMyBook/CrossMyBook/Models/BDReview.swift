//
//  BDReviews.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/6/22.
//

import Foundation
struct BDReview: Decodable {
    let reviewId: Int?
    let date: Date?
    let content: String?
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
        case reviewId = "review_id"
        case date
        case content
        case userName = "user_name"
    }
}
