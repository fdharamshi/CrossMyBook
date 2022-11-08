//
//  Release.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation

struct Release : Decodable {
    let copyId: Int
    let lat: Float
    let lon: Float
    let condition: String
    let shipping: String
    let distance: String
    let note: String
    
    enum CodingKeys : String, CodingKey {
        case copyId = "copy_id"
        case lat
        case lon
        case condition = "book_condition"
        case shipping = "charges"
        case note
        case distance = "max_distance"
    }
}
