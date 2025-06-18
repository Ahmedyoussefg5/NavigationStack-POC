//
// APIRouter.swift
// NavigationStackPOC
//
// Created by Youssef on 29/04/2025
//

import Foundation
import Alamofire

typealias Parameters = [String: any Any & Sendable]?

enum APIRouter: URLRequestConvertible {
    
    case login(parameters: Parameters)
    case sendPasswordResetCodeToEmail(parameters: Parameters)
    case validateSentCode(parameters: Parameters)
    case resetPaswordFinalStep(parameters: Parameters)
    case dashboard
    case orders(parameters: Parameters)
    case orderDetails(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .login, .sendPasswordResetCodeToEmail, .validateSentCode, .resetPaswordFinalStep:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .login(let parameters):
            parameters
        case .sendPasswordResetCodeToEmail(let parameters):
            parameters
        case .validateSentCode(let parameters):
            parameters
        case .resetPaswordFinalStep(let parameters):
            parameters
        case .orders(let parameters):
            parameters?.compactMapValues { $0 }
        default:
            nil
        }
    }
    
    var path: String {
        switch self {
        case .login:
            "auth/login"
        case .validateSentCode:
            "auth/forget-password"
        case .sendPasswordResetCodeToEmail:
            "auth/forget-password-code"
        case .resetPaswordFinalStep:
            "auth/reset-password"
        case .dashboard:
            "dashboard/stats"
        case .orderDetails(let id):
            "order/details/\(id)"
        case .orders:
            "dashboard/orders"
        }
    }
    
    var baseUrl: String {
        switch self {
        default:
            return Constants.baseUrl
        }
    }
}
