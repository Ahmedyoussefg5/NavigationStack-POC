//
//  Network.swift
//  BaseProject
//
//  Created by Youssef on 4/26/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Alamofire
import Combine
import Foundation

typealias NetworkCompletion<T> = (AFResult<T>) -> ()

protocol NetworkProtocol {
    func request<T: Sendable & Codable>(_ request: URLRequestConvertible, decodeTo type: T.Type) async -> AFResult<T>
    func cancelAllRequests()
}

final class Network {
    
    fileprivate let requestRetrierMiddleware = RequestRetrierMiddleware()
    fileprivate let requestAdapterMiddleware = RequestAdapterMiddleware()
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate lazy var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        let interceptor = Interceptor(adapter: requestAdapterMiddleware, retrier: requestRetrierMiddleware)
        let session = Session(configuration: configuration, interceptor: interceptor)
        return session
    }()
    
    func cancelAllRequests() {
        session.cancelAllRequests()
    }
}

extension Network: NetworkProtocol {
    func request<T: Sendable & Codable>(_ request: URLRequestConvertible, decodeTo type: T.Type) async -> AFResult<T> {
        await session
            .request(request)
            .asyncDecodable(of: type.self, queue: .global())
    }
}

public extension DataRequest {
    
    @discardableResult
    func asyncDecodable<T: Sendable & Codable>(
        of type: T.Type = T.self,
        queue: DispatchQueue,
        decoder: DataDecoder = JSONDecoder()
    ) async -> AFResult<T> {
        
        return await withCheckedContinuation({ continuation in
            self.responseDecodable(of: type, queue: queue, decoder: decoder) { response in
                switch response.result {
                case .success(let decodedResponse):
                    continuation.resume(returning: .success(decodedResponse))
                case .failure(let error):
#if DEBUG
            debugPrint("#DEBUG#", error.localizedDescription)
#endif
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
}
