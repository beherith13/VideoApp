//
//  API+VideoLibrary.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

enum VideoLibrary {} // namespace

extension VideoLibrary {
    enum API: APIRequest {
        case getVideoList
        
        var baseURL: String {
            return "https://private-f88bc-christianegohring.apiary-mock.com/"
        }
        
        func buildRequest() throws -> URLRequest {
            switch self {
            case .getVideoList:
                return try get("popular/videos")
            }
        }
    }
}

