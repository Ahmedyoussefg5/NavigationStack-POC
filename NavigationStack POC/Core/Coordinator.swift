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
    var sheet: Page? { get set }
    var fullScreenCover: Page? { get set }
    
    func build(page: Page, with coordinator: coordinator) -> view
    
    func push(page: any Hashable, animated: Bool)
    
    func pop(animated: Bool)
    
    func popToRoot()
    
    func presentSheet(_ sheet: Page)
    
    func presentFullScreenCover(_ cover: Page)
    
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
    
    func presentSheet(_ sheet: Page) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: Page) {
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
    @Published var sheet: HomeRouter?
    @Published var fullScreenCover: HomeRouter?
    
    lazy var paymetCoordinator = PaymentCoordinator()
    
    @AppStorage("isLoggedIn")
    var isLoggedIn: Bool = true
    
    init(path: NavigationPath, sheet: HomeRouter? = nil, fullScreenCover: HomeRouter? = nil) {
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
}

@MainActor
class Coordinator2: CoordinatorP {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: HomeRouter2?
    @Published var fullScreenCover: HomeRouter2?
    
    @AppStorage("isLoggedIn")
    var isLoggedIn: Bool = true
    
    init(path: NavigationPath, sheet: HomeRouter2? = nil, fullScreenCover: HomeRouter2? = nil) {
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
}

@MainActor
class PaymentCoordinator: CoordinatorP {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: PaymetFlow?
    @Published var fullScreenCover: PaymetFlow?
    
    @ViewBuilder
    func build(page: PaymetFlow, with coordinator: PaymentCoordinator) -> some View {
        switch page {
        case .root: Text("PaymetFlow-root")
        }
    }
}
