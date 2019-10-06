//
//  Video.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let channelId: Int
    let titleDefault: String
}

struct Video: Decodable {
    let imageURL: URL
    let titleDefault: String
    let tvShow: TVShow
}

extension Video {
    var galleryImageURL: URL {
        return imageURL.appending(profile: .medium).appending(channel: tvShow.channelId)
    }
}
