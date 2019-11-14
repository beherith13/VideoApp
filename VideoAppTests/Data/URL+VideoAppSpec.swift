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

final class URLVideoAppSpec: QuickSpec {
    override func spec() {
        var sut: URL!
        
        beforeEach {
            sut = URL(string: "http://test.video.app/url")
        }
        
        describe("Given video app url") {
            context("when initialized") {
                it("should append channel correctly") {
                    expect(sut.appending(channel: 2)) == URL(string: "http://test.video.app/url/wm:2")
                }

                it("should append profile correctly") {
                    expect(sut.appending(profile: .medium)) == URL(string: "http://test.video.app/url/profile:7tv-868x488")
                }
            }
        }
    }
}

