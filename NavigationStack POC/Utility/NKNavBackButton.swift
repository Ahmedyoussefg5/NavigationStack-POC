//
// NKNavBackButton.swift
// NavigationStackPOC
//
// Created by Youssef on 13/05/2025
//

import SwiftUI

struct NavBackButton: View {
    
    let dismiss: (()->())
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("ic-navi-back")
                .themeStyle
        }
    }
}

struct CloseNav: View {
    let action: (()->())
    
    var body: some View {
            Button {
                action()
            } label: {
                Image("ic-navi-close")
                    .themeStyle
            }
    }
}

struct NKSurveyBackButton: View {
    
    let hideBackButton : Bool?
    let dismiss: (()->())
    
    var body: some View {
        if let hideBackButton, hideBackButton == false{
            Button {
                dismiss()
            } label: {
                Image("ic-navi-back")
                    .themeStyle
            }
        }else{
            HStack{}.frame(width: 80, height: 80)
                .background(.clear)
        }
    }
}
