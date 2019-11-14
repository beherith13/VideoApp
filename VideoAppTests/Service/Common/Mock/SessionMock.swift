//
//  SessionMock.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

@testable import VideoApp

class SessionMock: Session {
    let stub: Data
    private(set) var lastRequest: URLRequest?
        
    init(stub: Data = Data([1, 2, 3, 4, 5])) {
        self.stub = stub
    }
    
    func data(request: URLRequest) -> Observable<Data> {
        lastRequest = request
        return .just(stub)
    }
}
