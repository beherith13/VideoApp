//
//  URL+VideoApp.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

enum ImagePofile: String {
    case medium = "7tv-868x488"
}

extension URL {
    func appending(channel channelId: Int) -> URL {
        return appendingPathComponent("wm:\(channelId)")
    }
    
    func appending(profile: ImagePofile) -> URL {
        return appendingPathComponent("profile:\(profile.rawValue)")
    }
}
