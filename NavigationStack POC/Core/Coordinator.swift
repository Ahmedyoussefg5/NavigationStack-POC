//
// Coordinator.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI

@MainActor
protocol CoordinatorP: ObservableObject {
    associatedtype Page: Hashable
    associatedtype coordinator
    associatedtype view: View
    
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }
    
    func build(page: Page, with coordinator: coordinator) -> view
    
    func push(page: any Hashable, animated: Bool)
    
    func pop(animated: Bool)
    
    func popToRoot()
    
    func presentSheet(_ sheet: Sheet)
    
    func presentFullScreenCover(_ cover: FullScreenCover)
    
    func dismissSheet()
    
    func dismissCover()
}

extension CoordinatorP {
    func push(page: any Hashable, animated: Bool = true) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.append(page)
        }
    }
    
    func pop(animated: Bool = true) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
}

@MainActor
class Coordinator: CoordinatorP {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    lazy var paymetCoordinator = PaymentCoordinator()
    
    @AppStorage("isLoggedIn")
    var isLoggedIn: Bool = true
    
    init(path: NavigationPath, sheet: Sheet? = nil, fullScreenCover: FullScreenCover? = nil) {
        self.path = path
        self.sheet = sheet
        self.fullScreenCover = fullScreenCover
    }
    
    @ViewBuilder
    func build(page: HomeRouter, with coordinator: Coordinator) -> some View {
        switch page {
        case .dashboard: DashboardView(viewModel: .init(coordinator: coordinator))
        case .orderDetails(let id): OrderDetails(viewModel: .init(coordinator: coordinator, orderId: id))
        case .paymetFlow(let flow):
            paymetCoordinator.build(page: flow, with: paymetCoordinator)
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

@MainActor
class Coordinator2: CoordinatorP {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    @AppStorage("isLoggedIn")
    var isLoggedIn: Bool = true
    
    init(path: NavigationPath, sheet: Sheet? = nil, fullScreenCover: FullScreenCover? = nil) {
        self.path = path
        self.sheet = sheet
        self.fullScreenCover = fullScreenCover
    }
    
    @ViewBuilder
    func build(page: HomeRouter2, with coordinator: Coordinator2) -> some View {
        switch page {
        case .dashboard: Text("Dashboard 2")
        case .orderDetails(let id): Text("Order Details \(id)")
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet, with coordinator: Coordinator2) -> some View {
        switch sheet {
        case .still: EmptyView()
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover, with coordinator: Coordinator2) -> some View {
        switch cover {
        case .still: EmptyView()
        }
    }
}

@MainActor
class PaymentCoordinator: CoordinatorP {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    @ViewBuilder
    func build(page: PaymetFlow, with coordinator: PaymentCoordinator) -> some View {
        switch page {
        case .root: Text("PaymetFlow-root")
        }
    }
}
