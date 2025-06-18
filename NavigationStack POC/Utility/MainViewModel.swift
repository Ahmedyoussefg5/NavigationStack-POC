//
// MainViewModel.swift
// NavigationStackPOC
//
// Created by Youssef on 30/04/2025
//

import SwiftUI

class MainViewModel: MainViewModelProtocol, ObservableObject {
    @MainActor @Published var isLoading: Bool = false
    @MainActor @Published var error: String?
    
    init() {
        
    }
}
