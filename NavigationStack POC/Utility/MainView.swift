//
// MainView.swift
// NavigationStackPOC
//
// Created by Youssef on 30/04/2025
//

import SwiftUI
import Observation

@MainActor
protocol Loadable {
    var isLoading: Bool { get set }
}

@MainActor
protocol ErrorPresentable {
    var error: String? { get set }
}

protocol MainViewModelProtocol: Loadable, ErrorPresentable {}

protocol MainView: View {
    associatedtype ViewModel: MainViewModelProtocol
    var viewModel: ViewModel { get }
}

// MARK: - RootView

struct RootView<Content: View, ViewModel: MainViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ObservableWrapper<ViewModel>
    let content: Content
    
    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = ObservableWrapper(viewModel)
        self.content = content()
    }
    
    var body: some View {
        content
            .overlay {
                if viewModel.value.isLoading {
                    LoaderView()
                }
                if viewModel.value.error != nil {
                    ErrorView(error: viewModel.value.error, isVisible: Binding<Bool>(
                        get: { viewModel.value.error != nil },
                        set: { newValue in if !newValue { viewModel.value.error = nil } })
                    )
                    .animation(.easeInOut(duration: 0.8), value: viewModel.value.error)
                }
            }
    }
}

// MARK: - Observable Wrapper for protocol conformance

class ObservableWrapper<T: MainViewModelProtocol>: ObservableObject {
    @Published var value: T
    
    init(_ value: T) {
        self.value = value
    }
}
