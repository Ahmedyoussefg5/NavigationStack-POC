//
// AppPages.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import Foundation
import Combine

enum HomeRouter: Hashable {
    static func == (lhs: HomeRouter, rhs: HomeRouter) -> Bool {
        switch (lhs, rhs) {
        case (.dashboard, .dashboard):
            return true
        case (.orderDetails, .orderDetails):
            return true
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .dashboard:
            hasher.combine("dashboard")
        case .orderDetails:
            hasher.combine("orderDetails")
        }
    }
        
    case dashboard
    case orderDetails(Int)
}

enum HomeRouter2: Hashable {
    static func == (lhs: HomeRouter2, rhs: HomeRouter2) -> Bool {
        switch (lhs, rhs) {
        case (.dashboard, .dashboard):
            return true
        case (.orderDetails, .orderDetails):
            return true
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .dashboard:
            hasher.combine("dashboard")
        case .orderDetails:
            hasher.combine("orderDetails")
        }
    }
        
    case dashboard
    case orderDetails(Int)
}

enum Sheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case still
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case still
}
