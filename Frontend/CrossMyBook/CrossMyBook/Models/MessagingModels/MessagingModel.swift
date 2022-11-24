//
//  MessagingModels.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import Foundation

// MARK: - MessagingModel
struct MessagingModel: Codable {
    let messages: [Message]
    let user1, user2: MessageUser
    let msg: String
    let success: Bool
}

// MARK: - Message
struct Message: Codable, Identifiable {
    var id = UUID()
    let sender: Int
    let message, timestamp: String
  
    enum CodingKeys: String, CodingKey {
        case sender, message, timestamp
    }
}

// MARK: - MessageUser
struct MessageUser: Codable {
    let name: String
    let id: Int
    let profileURL: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case profileURL = "profile_url"
    }
}
