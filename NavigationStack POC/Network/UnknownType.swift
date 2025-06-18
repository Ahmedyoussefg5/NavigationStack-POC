//
//  UnknownType.swift
//  BaseProject
//
//  Created by Youssef on 7/24/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

enum UnknownType<F: Codable, S: Codable>: Codable {
    
    case firstValue(F)
    case secoundValue(S)
    
    var value: String? {
        switch self {
            case .firstValue(let val):
                return (val as? String) ?? "\(val as? Int)"
            case .secoundValue(let val):
                return "\(val)"
        }
    }
    
    var valueCondable: Codable? {
        switch self {
            case .firstValue(let val):
                return val
            case .secoundValue(let val):
                return val
        }
    }
    
//    var intOrBool: Int? {
//        switch self {
//            case .firstValue(let val): // int
//                return val as? Int
//            case .secoundValue(let val):
//                return (val as? Bool)?.int
//        }
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(F.self) {
            self = .firstValue(value)
            return
        }
        if let value = try? container.decode(S.self) {
            self = .secoundValue(value)
            return
        }
        throw DecodingError.typeMismatch(UnknownType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .secoundValue(let x):
                try container.encode(x)
            case .firstValue(let x):
                try container.encode(x)
        }
    }
}
