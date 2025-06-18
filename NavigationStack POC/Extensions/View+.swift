//
// View+.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import SwiftUI
import SSToastMessage

extension View {
    func placeholder(_ text: String, imageName: ImageResource? = nil, when shouldShow: Bool, alignment: Alignment = .leading) -> some View {
        placeholder(when: shouldShow, alignment: alignment) {
            HStack(spacing: 8) {
                if let imageName {
                    Image(imageName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .scaledToFill()
                }
                Text(text)
                    .fontRegular(size: 16)
                    .foregroundColor(.gray500)
            }
        }
    }
    
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
//    func showError(isPresented: Binding<Bool>, message: String) -> some View {
//        present(isPresented: isPresented, type: .toast, position: .top) {
//            ErrorView(error: message)
//        }
//    }
    
    var withThemeEnvironment: some View {
        self
//            .environment(\.locale, Locale(identifier: NKLanguage.m.code))
//            .environment(\.layoutDirection, NKLanguage.m.isRTL ? .rightToLeft : .leftToRight)
    }
    
    var withArabicEnvironment: some View {
        self
            .environment(\.locale, Locale(identifier: "ar"))
            .environment(\.layoutDirection, .rightToLeft)
    }
    
    var withEnglishEnvironment: some View {
        self
            .environment(\.locale, Locale(identifier: "en"))
            .environment(\.layoutDirection, .leftToRight)
    }
    
    var themeStyle: some View {
        self
            .rotationEffect(.degrees(Locale.current.language.languageCode?.identifier == "ar" ? 180 : 0))
    }
}

extension View {
    func fontBlack(size: CGFloat) -> some View {
        self.font(.mainBlack(size))
    }
    
    func fontBold(size: CGFloat) -> some View {
        self.font(.mainBold(size))
    }
    
    func fontHeavy(size: CGFloat) -> some View {
        self.font(.mainHeavy(size))
    }
    
    func fontLight(size: CGFloat) -> some View {
        self.font(.mainLight(size))
    }
    
    func fontRegular(size: CGFloat) -> some View {
        self.font(.mainRegular(size))
    }
    
    func fontMedium(size: CGFloat) -> some View {
        self.font(.mainMedium(size))
    }
    
    func fontSemibold(size: CGFloat) -> some View {
        self.font(.mainSemibold(size))
    }
    
    func fontUltralight(size: CGFloat) -> some View {
        self.font(.mainUltralight(size))
    }
}
