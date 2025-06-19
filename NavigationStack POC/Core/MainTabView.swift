//
// MainTabView.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

struct MainTabView: View {
    @StateObject var coordinator: Coordinator
    @StateObject var coordinator2: Coordinator2
    
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .dashboard, with: coordinator)
                    .navigationDestination(for: HomeRouter.self) { page in
                        coordinator.build(page: page, with: coordinator)
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.build(page: sheet, with: coordinator)
                    }
                    .fullScreenCover(item: $coordinator.fullScreenCover) { cover in
                        coordinator.build(page: cover, with: coordinator)
                    }
            }
            .tabItem {
                Label("Dashboard".localize, image: "Vector 3232")
            }
            .toolbarBackground(.mainWhite, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            
            NavigationStack(path: $coordinator2.path) {
                coordinator2.build(page: .dashboard, with: coordinator2)
                    .navigationDestination(for: HomeRouter2.self) { page in
                        coordinator2.build(page: page, with: coordinator2)
                    }
                    .sheet(item: $coordinator2.sheet) { sheet in
                        coordinator2.build(page: sheet, with: coordinator2)
                    }
                    .fullScreenCover(item: $coordinator2.fullScreenCover) { item in
                        coordinator2.build(page: item, with: coordinator2)
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
