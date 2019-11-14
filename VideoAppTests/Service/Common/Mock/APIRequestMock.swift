//
//  APIRequestMock.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

@testable import VideoApp

class APIRequestMock: APIRequest {
    let baseURL: String = "http://my.video.app"
    let stub: URLRequest?
    private(set) var buildCallCount = 0

    init(stub: URLRequest? = URLRequest(url: URL(string: "http://my.video.app")!)) {
        self.stub = stub
    }

    func buildRequest() throws -> URLRequest {
        buildCallCount += 1
        guard let stub = stub else { throw MockError.test }
        return stub
    }
}
