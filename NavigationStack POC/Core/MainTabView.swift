//
// MainTabView.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

struct MainTabView: View {
    @StateObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .dashboard, with: coordinator)
                    .navigationDestination(for: AppPages.self) { page in
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
        }
    }
}
