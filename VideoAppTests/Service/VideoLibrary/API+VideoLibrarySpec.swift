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

final class APIVideoLibrarySpec: QuickSpec {
    override func spec() {
        var sut: APIRequest!
        var result: URLRequest?

        describe("Given get video list API") {
            beforeEach {
                sut = VideoLibrary.API.getVideoList
            }

            context("when build request") {
                beforeEach {
                    result = try? sut.buildRequest()
                }
                
                it("it should have correct method") {
                    expect(result?.httpMethod) == "GET"
                }

                it("it should have correct URL") {
                    expect(result?.url) == URL(string: "https://private-f88bc-christianegohring.apiary-mock.com/popular/videos")
                }
            }
        }
    }
}

