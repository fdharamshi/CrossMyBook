//
//  AlertModel.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/10/22.
//

import Foundation

// MARK: - Welcome
struct AlertModel: Codable {
    let msg: String
    let success: Bool
    let pendingRequests, acceptedRequests: [Request]

    enum CodingKeys: String, CodingKey {
        case msg, success
        case pendingRequests = "pending_requests"
        case acceptedRequests = "accepted_requests"
    }
}

// MARK: - Request
struct Request: Codable, Identifiable {
    let id = UUID()
    let userID: Int
    let userName: String
    let copyID, listingID: Int
    let date: String
    let lat, lon: Double
    let note: String
    let requestID: Int
    let coverURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case copyID = "copy_id"
        case listingID = "listing_id"
        case date, lat, lon, note
        case requestID = "request_id"
        case coverURL = "cover_url"
        case title
    }
}

