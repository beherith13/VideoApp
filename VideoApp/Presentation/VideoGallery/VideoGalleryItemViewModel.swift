//
//  VideoGalleryItemViewModel.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxCocoa

protocol VideoGalleryItemViewModel {
    var title: Driver<String> { get }
    var channel: Driver<String> { get }
    var imageURL: Driver<URL> { get }
    var focused: Driver<Bool> { get }
}

protocol VideoGalleryItemViewModelFactory {
    func create(data: VideoGalleryItem.Data, input: VideoGalleryItem.Input) -> VideoGalleryItemViewModel
}

enum VideoGalleryItem {} // namespace

extension VideoGalleryItem {
    struct Input {
        let focus: Driver<Bool>
    }
    
    typealias Data = Video
    
    struct Factory: VideoGalleryItemViewModelFactory {
        func create(data: VideoGalleryItem.Data, input: VideoGalleryItem.Input) -> VideoGalleryItemViewModel {
            return ViewModel(data: data, input: input)
        }
    }
    
    class ViewModel: VideoGalleryItemViewModel {
        let title: Driver<String>
        let channel: Driver<String>
        let imageURL: Driver<URL>
        let focused: Driver<Bool>

        init(data: Data, input: Input) {
            focused = input.focus.startWith(false).distinctUntilChanged()
            imageURL = .just(data.galleryImageURL)
            title = .just(data.titleDefault)
            channel = .just(data.tvShow.titleDefault)
        }
    }
}

