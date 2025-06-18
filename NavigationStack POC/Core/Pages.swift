//
// Pages.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

extension Coordinator {
    @MainActor @ViewBuilder
    func build(page: AppPages, with coordinator: Coordinator) -> some View {
        switch page {
        case .dashboard: DashboardView(viewModel: .init(coordinator: coordinator))
        case .orderDetails(let id): OrderDetails(viewModel: .init(coordinator: coordinator, orderId: id))
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet, with coordinator: Coordinator) -> some View {
        switch sheet {
        case .still: EmptyView()
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover, with coordinator: Coordinator) -> some View {
        switch cover {
        case .still: EmptyView()
        }
    }
}
