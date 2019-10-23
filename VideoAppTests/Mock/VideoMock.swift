//
//  VideoMock.swift
//  VideoAppTests
//
//  Created by Beherith on 16.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
@testable import VideoApp

extension Video {
    static let stub: Video =
        Video(
            imageURL: URL(string: "http://mockvideogallery1.com")!,
            titleDefault: "title1",
            tvShow: TVShow(channelId: 1, titleDefault: "showTitle1")
    )
    
    static let stubArray: [Video] = [
        Video(
            imageURL: URL(string: "http://mockvideogallery1.com")!,
            titleDefault: "title1",
            tvShow: TVShow(channelId: 1, titleDefault: "showTitle1")
        ),
        Video(
            imageURL: URL(string: "http://mockvideogallery2.com")!,
            titleDefault: "title2",
            tvShow: TVShow(channelId: 2, titleDefault: "showTitle2")
        )
    ]
}

extension Video: Equatable {
    public static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.titleDefault == rhs.titleDefault &&
            lhs.imageURL == rhs.imageURL &&
            lhs.tvShow == rhs.tvShow
    }
}

extension TVShow: Equatable {
    public static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.channelId == rhs.channelId &&
            lhs.titleDefault == rhs.titleDefault
    }
}




