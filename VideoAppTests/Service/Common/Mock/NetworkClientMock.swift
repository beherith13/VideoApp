//
//  NetworkClientMock.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

@testable import VideoApp

class NetworkClientMock<S: Decodable>: NetworkClient {
    private let stub: S?
    private(set) var lastRequest: APIRequest?
        
    init(stub: S? = nil) {
        self.stub = stub
    }
    
    func perform<Response>(request: APIRequest) -> Observable<Response> where Response : Decodable {
        lastRequest = request
        
        guard let stub = stub, let typedStub = stub as? Response else {
            return .error(MockError.test)
        }
        
        return .just(typedStub)
    }
}


