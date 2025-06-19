//
// OrderDetails.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

struct OrderDetails: View {
    @StateObject var viewModel: OrderDetailsModel
    @State var showPopup: Bool = false
    
    var body: some View {
        RootView(viewModel: viewModel) {
            VStack(spacing: .zero) {
                VStack(spacing: .zero) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.red)
                        .frame(width: 300, height: 200)
                }
                .padding(.bottom, 16)
            }
            .background(Color(hex: "#FCF8F8").ignoresSafeArea())
            .task {
                await viewModel.getOrderDetails()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
