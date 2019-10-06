//
//  VideoListViewModel.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol VideoGalleryViewModel {
    var items: Driver<[VideoGalleryItemViewModel]> { get }
    var error: Driver<String?> { get }
    var isLoading: Driver<Bool> { get }
}

protocol VideoGalleryViewModelFactory {
    func create(input: VideoGallery.Input) -> VideoGalleryViewModel
}

enum VideoGallery {} // namespace

extension VideoGallery {
    struct Handlers {
        let selected: (Video) -> ()
    }
    
    struct Context {
        let service: VideoService
        let factory: VideoGalleryItemViewModelFactory
    }
    
    struct Input {
        let enable: Signal<Bool>
        let focus: Signal<Int?>
        let select: Signal<Void>
        let retry: Signal<Void>
    }
    
    struct Factory: VideoGalleryViewModelFactory {
        private let handlers: Handlers
        private let context: Context

        init(context: Context, handlers: Handlers) {
            self.handlers = handlers
            self.context = context
        }
        
        func create(input: Input) -> VideoGalleryViewModel {
            return ViewModel(context: context, input: input, handlers: handlers)
        }
    }
    
    struct ViewModel: VideoGalleryViewModel {
        private let disposeBag = DisposeBag()

        let items: Driver<[VideoGalleryItemViewModel]>
        let error: Driver<String?>
        let isLoading: Driver<Bool>

        init(context: Context, input: Input, handlers: Handlers) {
            let errorSubject = PublishSubject<Error>()
            let errorMessage: Driver<String?> = errorSubject
                .map { $0.localizedDescription }
                .asDriver(onErrorJustReturn: nil)
            
            let enabled = input.enable
                .filter { $0 }
                .distinctUntilChanged()
                .map { _ in () }
            
            let startLoading = Signal.merge(enabled, input.retry)
                .asDriver(onErrorJustReturn: ())
            let endLoading = startLoading.flatMap { _ in
                return context.service.getVideoList().asDriver { error in
                    errorSubject.onNext(error)
                    return Driver.just([])
                }
            }
            
            let focusedIndex = input.focus.asDriver(onErrorJustReturn: nil)
            let focusedVideo = focusedIndex.withLatestFrom(endLoading) { index, items in
                return index.map { items[$0] }
            }

            items = endLoading.map { videos in
                return videos.enumerated().map { offset, video in
                    let focus = focusedIndex.map { $0 == offset }
                    let input = VideoGalleryItem.Input(focus: focus)
                    
                    return context.factory.create(data: video, input: input)
                }
            }.startWith([])
            
            isLoading = Driver.merge(
                startLoading.map { _ in true },
                endLoading.map { _ in false }
            ).startWith(false)

            error = Driver.merge(
                startLoading.map { _ in nil },
                errorMessage
            ).startWith(nil)
            
            input.select
                .withLatestFrom(focusedVideo)
                .emit(onNext: { video in
                    guard let video = video else { return }
                    handlers.selected(video)
                }).disposed(by: disposeBag)
        }
    }
}
