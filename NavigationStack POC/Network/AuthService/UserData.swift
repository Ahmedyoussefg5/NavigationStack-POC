//
// UserData.swift
// NavigationStackPOC
//
// Created by Youssef on 13/05/2025
//

import Foundation

struct UserData: Codable {
    let token: String
    let user: User?
}

// MARK: - User
struct User: Codable {
    let avatar: String?
    let id: Int?
    let deviceToken, lastName, avatarOriginal: String?
    let email, createdAt, updatedAt, userType: String?
    let name: String?
    let firstName: String?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case deviceToken = "device_token"
        case lastName = "last_name"
        case avatarOriginal = "avatar_original"
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userType = "user_type"
        case name
        case firstName = "first_name"
    }
}
