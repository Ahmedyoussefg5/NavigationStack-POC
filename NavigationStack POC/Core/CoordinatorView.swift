//
// CoordinatorView.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator(path: .init())
    @StateObject private var coordinator2 = Coordinator2(path: .init())
    
    var body: some View {
        let _ = Self._printChanges()
        ZStack {
            tabView
                .transition(.move(edge: .trailing))
        }
        .animation(.smooth, value: coordinator.isLoggedIn)
    }
    
    var tabView: some View {
        MainTabView(coordinator: coordinator, coordinator2: coordinator2)
    }
}
