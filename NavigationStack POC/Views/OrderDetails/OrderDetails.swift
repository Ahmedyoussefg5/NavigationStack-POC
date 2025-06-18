//
// OrderDetails.swift
// NavigationStackPOC
//
// Created by Youssef on 07/05/2025
//

import SwiftUI

struct OrderDetails: View {
    @ObservedObject var viewModel: OrderDetailsModel
    @State var showPopup: Bool = false
    
    var body: some View {
        RootView(viewModel: viewModel) {
            VStack(spacing: .zero) {
                VStack(spacing: .zero) {
                    backView
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
    
    var backView: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.coordinator.pop(animated: false)
            } label: {
                Image(.vector22)
                    .resizable()
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .frame(width: 40, height: 40)
                    .cornerRadius(8)
            }
            
            Text("Order Details".localize)
                .fontSemibold(size: 24)
                .foregroundColor(.mainBlack)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.bottom, 16)
    }
}
