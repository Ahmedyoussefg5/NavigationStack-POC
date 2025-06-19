//
// MainTabView.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

struct MainTabView: View {
    @StateObject var coordinator: Coordinator
    @StateObject var coordinator2: Coordinator
    
    init(coordinator: any CoordinatorP) {
        _coordinator = .init(wrappedValue: .init(path: coordinator.path))
        _coordinator2 = .init(wrappedValue: .init(path: coordinator.path))
    }
    
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .dashboard, with: coordinator)
                    .navigationDestination(for: HomeRouter.self) { page in
                        coordinator.build(page: page, with: coordinator)
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.buildSheet(sheet: sheet, with: coordinator)
                    }
                    .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                        coordinator.buildCover(cover: item, with: coordinator)
                    }
            }
            .tabItem {
                Label("Dashboard".localize, image: "Vector 3232")
            }
            .toolbarBackground(.mainWhite, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            
            NavigationStack(path: $coordinator2.path) {
                coordinator.build(page: .dashboard, with: coordinator)
                    .navigationDestination(for: HomeRouter.self) { page in
                        coordinator.build(page: page, with: coordinator)
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.buildSheet(sheet: sheet, with: coordinator)
                    }
                    .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                        coordinator.buildCover(cover: item, with: coordinator)
                    }
            }
            .tabItem {
                Label("Dashboard2".localize, image: "Vector 3232")
            }
            .toolbarBackground(.mainWhite, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}
