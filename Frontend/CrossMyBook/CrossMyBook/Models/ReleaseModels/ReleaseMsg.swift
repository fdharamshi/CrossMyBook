//
//  ReleaseMsg.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation

struct ReleaseMsg: Codable {
    let msg: String
    let success: Bool
    let release_id:Int
    let copy_id:Int
    
    enum CodingKeys: String, CodingKey {
        case success, msg
        case copy_id
        case release_id = "listing_id"
    }
}
