//
//  BDCopy.swift
//  Book Copy struct for book detail page
//  CrossMyBook
//
//  Created by Caifei H on 11/6/22.
//

import Foundation
struct BDCopy: Decodable {
    let copyId: Int?
    let status: Int?
    let ownerName: String?
    let ownerProfileUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case copyId = "copy_id"
        case status
        case ownerName = "owner_name"
        case ownerProfileUrl = "owner_profile_url"
    }
}
