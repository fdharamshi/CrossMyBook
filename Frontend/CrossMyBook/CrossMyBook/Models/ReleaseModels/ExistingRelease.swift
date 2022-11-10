//
//  ExistingRelease.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/10/22.
//

import Foundation
struct ExistingRelease: Codable {
    let listID: Int
    let lat: Float
    let lon: Float
    let condition: String
    let distance: String
    let shipping: String
    let note: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case listID = "listing_id"
        case lat
        case lon
        case condition = "book_condition"
        case distance = "max_distance"
        case shipping = "charges"
        case note
        case status
    }
}
