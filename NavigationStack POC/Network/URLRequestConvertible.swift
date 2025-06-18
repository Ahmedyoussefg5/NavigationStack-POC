//
//  URLRequestConveritble.swift
//  Torch
//
//  Created by Youssef on 8/11/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: [String: any Any & Sendable]? { get }
    var baseUrl: String { get }
    var path: String { get }
    var authorization: String? { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestConvertible {
    
    var encoding: ParameterEncoding {
        switch method {
            case .post:
                return JSONEncoding.default
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
        }
    }
    
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var authorization: String? {
        return AuthService.userData?.token
    }
    
    var fullUrl: String {
        "\(baseUrl)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: fullUrl)!
        
        var urlRequest = URLRequest(url: url)
        // var method: HTTPMethod = .get
        // if parameters != nil { method = .post }
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.lang, forHTTPHeaderField: "lang")
        urlRequest.setValue(Constants.os, forHTTPHeaderField: "ios")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        // urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let authorization = authorization {
            urlRequest.setValue("\(authorization)", forHTTPHeaderField: "Authorization")
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
