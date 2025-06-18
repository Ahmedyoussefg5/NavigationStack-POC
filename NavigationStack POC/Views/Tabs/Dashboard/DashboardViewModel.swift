//
// DashboardViewModel.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI
import Combine

final class DashboardViewModel: MainViewModel {
    let coordinator: Coordinator
    nonisolated private let repo = Repository()
    @Published @MainActor var ordersList: [String] = [
        "1", "2", "3"
    ]
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init()
    }
    
    func getOrderList(currentPage: Int) async {
//        ordersList = [
//            "1", "2", "3"
//        ]
    }
}
