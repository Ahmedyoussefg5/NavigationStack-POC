//
// RemoteImage.swift
// NavigationStackPOC
//
// Created by Youssef on 05/05/2025
//

import SwiftUI
import SDWebImageSwiftUI

struct RemoteImage<I:View, P:View>: View {
    let url: URL?
    let content: (Image) -> I
    let placeholder: () -> P
    
    init(url: URL?, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    init(url: String?, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) {
        self.url = URL(string: url ?? "")
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        WebImage(url: url, content: content, placeholder: placeholder)
    }
}
