//
// NavigationStackPOC.swift
// NavigationStackPOC
//
// Created by Youssef on 28/04/2025
//

import SwiftUI
import AlamofireEasyLogger
import IQKeyboardManagerSwift

@main
struct NavigationStackPOC: App {
    
    let alamofireLogger = FancyAppAlamofireLogger(prettyPrint: true) {
        print($0)
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .onAppear {
                    IQKeyboardManager.shared.isEnabled = true
                    IQKeyboardManager.shared.enableAutoToolbar = true
                    
                    UITabBar.appearance().shadowImage = UIImage()
                    UITabBar.appearance().backgroundImage = UIImage()
                    UITabBar.appearance().backgroundColor = UIColor.white
                    UITabBar.appearance().clipsToBounds = true
                }
        }
    }
}
