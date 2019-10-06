//
//  VideoService.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

protocol VideoService {
    func getVideoList() -> Observable<[Video]>
}

extension VideoLibrary {
    class Service: BaseService, VideoService {
        func getVideoList() -> Observable<[Video]> {
            return client.perform(request: API.getVideoList)
        }
    }
}
