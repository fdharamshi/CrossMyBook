//
//  LoginModel.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/15/22.
//

import Foundation

// MARK: LoginModel
struct AuthModel: Codable {
    let msg: String
    let success: Bool
    let user: User?
}

// MARK: - User
struct User: Codable {
    let userID: Int
    let profilePicture: String
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case profilePicture = "profile_picture"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
