//
// OrderDetailsModel.swift
// NavigationStackPOC
//
// Created by Youssef on 15/05/2025
//

import SwiftUI

final class OrderDetailsModel: MainViewModel {
    let coordinator: Coordinator
    private let orderId: Int
    nonisolated private let repo = Repository()
    
    init(coordinator: Coordinator, orderId: Int) {
        self.coordinator = coordinator
        self.orderId = orderId
    }
    
    @MainActor
    func getOrderDetails() async {
        
    }
}

