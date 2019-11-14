//
//  BaseServiceSpec.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Quick
import Nimble

@testable import VideoApp

struct TestAPIRequest: APIRequest {
    let baseURL: String
    
    func buildRequest() throws -> URLRequest {
        fatalError("not implemented")
    }
}

final class APISpec: QuickSpec {
    override func spec() {
        var sut: APIRequest!

        describe("Given API request") {
            context("when build GET request") {
                var result: URLRequest!

                beforeEach {
                    sut = TestAPIRequest(baseURL: "http://test.video.app")
                    result = try? sut.get("test")
                }
                
                it("it should have correct method") {
                    expect(result?.httpMethod) == "GET"
                }

                it("it should have correct URL") {
                    expect(result?.url) == URL(string: "http://test.video.app/test")
                }
            }

            context("when build request with invalid base URL") {
                beforeEach {
                    sut = TestAPIRequest(baseURL: "")
                }
                
                it("it should throw malformed URL error") {
                    expect { try sut.get("test") }.to(throwError(API.Error.malformedURL))
                }
            }
        }
    }
}

