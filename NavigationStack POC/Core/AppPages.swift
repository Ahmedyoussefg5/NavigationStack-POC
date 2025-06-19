//
// AppPages.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import Foundation
import Combine

enum HomeRouter: Hashable, Identifiable {
    var id: String {
        switch self {
        case .dashboard:
            return "dashboard"
        case .orderDetails(let id):
            return "orderDetails_\(id)"
        case .paymetFlow(let flow):
            switch flow {
            case .root:
                return "paymetFlowRoot"
            }
        }
    }
    
    case dashboard
    case orderDetails(Int)
    case paymetFlow(PaymetFlow)
}

enum PaymetFlow: Hashable {
    case root
}

enum HomeRouter2: Hashable, Identifiable {
    var id: String {
        switch self {
        case .dashboard:
            return "dashboard"
        case .orderDetails(let id):
            return "orderDetails_\(id)"
        }
    }
    
    case dashboard
    case orderDetails(Int)
}
