//
//  JsonServiceMock.swift
//  VideoAppTests
//
//  Created by Beherith on 16.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

@testable import VideoApp

extension VideoLibrary {
    class Mock: VideoService {
        private var subject = PublishSubject<[Video]>()
        
        func send(_ items: [Video]) {
            subject.onNext(items)
        }

        func send(_ error: Error) {
            subject.onError(error)
        }

        func getVideoList() -> Observable<[Video]> {
            subject = PublishSubject<[Video]>()
            return subject
        }
    }
}
