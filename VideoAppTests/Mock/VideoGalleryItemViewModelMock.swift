//
//  VideoGalleryItemFactoryMock.swift
//  VideoAppTests
//
//  Created by Beherith on 16.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import VideoApp

extension VideoGalleryItem {
    class FactoryMock: VideoGalleryItemViewModelFactory {
        func create(data: VideoGalleryItem.Data, input: VideoGalleryItem.Input) -> VideoGalleryItemViewModel {
            return Mock(input: input)
        }
    }
    
    struct Mock: VideoGalleryItemViewModel {
        private let disposeBag = DisposeBag()
        
        let focusedRelay = BehaviorRelay<Bool?>(value: false)
        
        let title: Driver<String>
        let channel: Driver<String>
        let imageURL: Driver<URL>
        let focused: Driver<Bool>
        
        init(input: VideoGalleryItem.Input,
             title: String = "title",
             channel: String = "channel",
             imageURL: URL = URL(string: "http://mockvideogallery.com")!) {
            self.title = .just(title)
            self.channel = .just(channel)
            self.imageURL = .just(imageURL)
            self.focused = input.focus
            
            input.focus.drive(focusedRelay).disposed(by: disposeBag)
        }
    }
}

