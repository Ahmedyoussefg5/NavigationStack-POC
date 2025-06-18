//
//  AppError.swift
//  NobyLynkClient
//
//  Created by Youssef on 07/05/2023.
//

import Foundation

protocol AppError: LocalizedError {
    var validatorErrorAssociatedMessage: String { get }
}

enum MyAppError: AppError {
    
    case networkError
    case businessError(String)
    case basicError
    
     var validatorErrorAssociatedMessage: String {
        switch self {
        case .networkError:
            return Constants.Error.networkErrorMessage
        case .businessError( let error):
            return error
        case .basicError:
            return "Something wrong happened, try again later."
        }
    }
}
