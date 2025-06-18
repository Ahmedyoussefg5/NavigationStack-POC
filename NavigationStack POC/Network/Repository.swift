//
//  Repository.swift
//  Son App
//
//  Created by Youssef on 3/1/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Combine
import Alamofire

final class Repository: @unchecked Sendable {
    
    private var network: NetworkProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        network = Network()
    }
    
    fileprivate func handleRequestResponse<U: BaseCodable>(_ result: AFResult<U>) -> Result<U, Error> {
        switch result {
        case .success(let data):
            if data.isSuccess {
                return .success(data)
            } else {
                return .failure(NSError.create(description: data.message ?? "No message"))
            }
        case .failure(let error):
            return .failure(NSError.create(description: error.localizedDescription))
        }
    }
    
    func request<U: BaseCodable & Sendable>(_ model: U.Type, _ request: APIRouter) async -> Result<U, Error> {
        
        await network
            .request(request, decodeTo: U.self)
            .pipeThrough(handleRequestResponse)
    }
    
    func cancelAllRequests() {
        network.cancelAllRequests()
    }
}

extension Result {
    func pipeThrough<T, E: Error>(_ transform: (Self) -> Result<T, E>) -> Result<T, E> {
        transform(self)
    }
}
