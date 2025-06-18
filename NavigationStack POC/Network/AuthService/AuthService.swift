//
//  UserData.swift
//  Torch
//
//  Created by Youssef on 8/11/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import SwiftUI

typealias UserDataModel = UserData

struct AuthService: Sendable {
        
    private init () {
        
    }
    
    private let userDataKey = "_User_|_Data_"
        
    fileprivate func getUserData() -> UserDataModel? {
        let defaults = UserDefaults.standard
        guard let savedPerson = defaults.object(forKey: userDataKey) as? Data,
              let loadedData = try? JSONDecoder().decode(UserDataModel.self, from: savedPerson)
        else { return nil }
        return loadedData
    }
    
    fileprivate func setUserData(_ newValue: UserDataModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newValue) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userDataKey)
        } else {
            fatalError("Unable To Save User Data")
        }
    }
    
    static var userData: UserDataModel? {
        get {
            let authService = AuthService()
            return authService.getUserData()
        } set {
            let authService = AuthService()
            authService.setUserData(newValue)
        }
    }
        
    static let shared = AuthService()
}
