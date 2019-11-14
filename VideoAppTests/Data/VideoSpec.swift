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

final class VideoSpec: QuickSpec {
    override func spec() {
        var sut: Video!
        
        beforeEach {
            sut = Video.stub
        }
        
        describe("Given Video model") {
            context("when initialized") {
                it("should have correct gallery image URL") {
                    expect(sut.galleryImageURL) == URL(string: "http://mockvideogallery1.com/profile:7tv-868x488/wm:1")
                }
            }
        }
    }
}

