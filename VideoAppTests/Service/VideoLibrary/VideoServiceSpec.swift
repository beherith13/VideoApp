//
//  BaseServiceSpec.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Quick
import Nimble
import RxBlocking

@testable import VideoApp

final class VideoServiceSpec: QuickSpec {
    override func spec() {
        var networkClient: NetworkClientMock<[Video]>!
        var sut: VideoService!
        var result: BlockingObservable<[Video]>!
        
        describe("Given VideoService") {
            context("when getting video list call succeeds") {
                beforeEach {
                    networkClient = NetworkClientMock(stub: Video.stubArray)
                    sut = VideoLibrary.Service(client: networkClient)
                    result = sut.getVideoList().toBlocking()
                }
                
                it("should pass proper API to network client") {
                    expect(networkClient.lastRequest as? VideoLibrary.API) == .getVideoList
                }
                
                it("should return result from client") {
                    expect { try result.single() } == Video.stubArray
                }
            }

            context("when getting video list call fails") {
                beforeEach {
                    networkClient = NetworkClientMock()
                    sut = VideoLibrary.Service(client: networkClient)
                    result = sut.getVideoList().toBlocking()
                }
                
                it("should return error from client") {
                    expect { try result.single() }.to(throwError(MockError.test))
                }
            }
        }
    }
}

