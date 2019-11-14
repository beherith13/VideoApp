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

final class BaseServiceSpec: QuickSpec {
    override func spec() {
        let networkClient = NetworkClientMock<Video>()
        var sut: BaseService!
        
        beforeEach {
            sut = BaseService(client: networkClient)
        }
        
        describe("Given BaseService") {
            context("when created") {
                it("should have initialized client") {
                    expect(sut.client) === networkClient
                }
            }
        }
    }
}

