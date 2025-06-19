//
// AppPages.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import Foundation
import Combine

enum HomeRouter: Hashable {
    case dashboard
    case orderDetails(Int)
    case paymetFlow(PaymetFlow)
}

enum PaymetFlow: Hashable {
    case root
}

enum HomeRouter2: Hashable {
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
