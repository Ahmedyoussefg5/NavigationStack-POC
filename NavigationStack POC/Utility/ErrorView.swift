//
// ErrorView.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI

struct ErrorView: View {
    var error: String?
    @Binding var isVisible: Bool
    @State private var animate = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            if isVisible {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Error occurred!".localize)
                            .padding(.all, 16)
                            .fontBold(size: 18)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(error ?? "")
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            .padding(.top, 6)
                            .fontMedium(size: 14)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(Color.mainRed)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .shadow(radius: 5)
                    .offset(y: animate ? 0 : -200) // start offscreen
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: animate)

                    Spacer()
                }
                .padding(.top, 15)
                .onAppear {
                    animate = true

                    timer?.invalidate()
                    timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            DispatchQueue.main.async {
                                animate = false
                            }
                        }

                        // Delay to allow the animation to finish before removing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isVisible = false
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                }
            }
        }
    }
}
