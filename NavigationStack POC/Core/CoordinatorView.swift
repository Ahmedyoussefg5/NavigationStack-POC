//
// CoordinatorView.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator(path: .init())
    
    var body: some View {
        ZStack {
            tabView
                .transition(.move(edge: .trailing))
        }
        .animation(.smooth, value: coordinator.isLoggedIn)
    }
    
    var tabView: some View {
        MainTabView(coordinator: coordinator)
    }
}
