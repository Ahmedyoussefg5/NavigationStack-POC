//
// UIA.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
