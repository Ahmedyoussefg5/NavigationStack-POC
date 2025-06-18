//
//  BaseCodable.swift
//  BaseProject
//
//  Created by Youssef on 7/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

protocol BaseCodable: Codable {
    var isSuccess: Bool { get }
    var message: String? { get }
    var status: Bool? { get }
}

extension BaseCodable {
    var isSuccess: Bool {
        return status ?? false
    }
}

struct BaseModelData<T: Codable & Sendable>: BaseCodable {
    var message: String?
    var status: Bool?
    let data: T?
}

struct BaseModel: BaseCodable {
    var message: String?
    var status: Bool?
}

struct EmptyModel: Codable {
    
}

// MARK: - Links
struct Links: Codable {
    let prev: String?
    let first: String?
    let next: String?
    let last: String?
}

// MARK: - Meta
struct Meta: Codable {
    let from, perPage, total: Int?
    let links: [Link]?
    let currentPage, lastPage: Int?
    let path: String?
    let to: Int?

    enum CodingKeys: String, CodingKey {
        case from
        case perPage = "per_page"
        case total, links
        case currentPage = "current_page"
        case lastPage = "last_page"
        case path, to
    }
    
    // MARK: - Link
    struct Link: Codable {
        let url: String?
        let label: String?
        let active: Bool?
    }
}
