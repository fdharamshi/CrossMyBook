//
//  ConversationModel.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import Foundation

// MARK: - ConversationModel
struct ConversationModel: Codable {
    let conversations: [Conversation]
    let msg: String
    let success: Bool
}

// MARK: - Conversation
struct Conversation: Codable, Identifiable {
    var id = UUID()
    let user: ConversationUser
  
  enum CodingKeys: String, CodingKey {
      case user
  }
}

// MARK: - User
struct ConversationUser: Codable {
    let name: String
    let profileURL: String
    let userID: Int
    let lastMessage: String

    enum CodingKeys: String, CodingKey {
        case name
        case profileURL = "profile_url"
        case userID = "user_id"
        case lastMessage = "last_message"
    }
}

