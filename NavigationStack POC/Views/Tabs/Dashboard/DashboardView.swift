//
// DashboardView.swift
// NavigationStackPOC
//
// Created by Youssef on 03/05/2025
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        RootView(viewModel: viewModel) {
            VStack(spacing: .zero) {
                ScrollView {
                    
                    Text("Orders")
                        .fontSemibold(size: 24)
                        .foregroundColor(.mainBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    LazyVStack {
                        ForEach(viewModel.ordersList, id: \.self) { item in
                            Button {
                                viewModel.coordinator.push(page: HomeRouter.orderDetails(item.int ?? .zero), animated: false)
                            } label: {
                                Text(item)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getOrderList(currentPage: 0)
                }
            }
        }
        .background(Color(hex: "#FCF8F8").ignoresSafeArea())
    }
}

//#Preview {
//    DashboardView(viewModel: .init(coordinator: .init()))
//}
