//
//  NetworkMiddleware.swift
//  Torch
//
//  Created by Youssef on 8/11/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation
import Alamofire

final class RequestAdapterMiddleware: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("en", forHTTPHeaderField: "lang")
        urlRequest.setValue("os", forHTTPHeaderField: "ios")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        // urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthService.userData?.token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
}

final class RequestRetrierMiddleware: RequestRetrier {
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let statusCode = request.response?.statusCode
        
        if statusCode == 401 {
            // AppWindowManger.restartAppAndRemoveUserDefaults()
            completion(.doNotRetry)
        } else {
            completion(.doNotRetry)
        }
    }
}
