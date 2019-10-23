//
//  VideoGalleryViewModelSpec.swift
//  VideoAppTests
//
//  Created by Beherith on 23.10.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest

@testable import VideoApp

final class VideoGalleryItemViewModelSpec: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        var focusRelay: PublishRelay<Bool>!
        var focusObserver: TestableObserver<Bool>!
        var titleObserver: TestableObserver<String>!
        var channelObserver: TestableObserver<String>!
        var imageURLObserver: TestableObserver<URL>!
        
        var sut: VideoGalleryItemViewModel!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            disposeBag = DisposeBag()
            
            focusRelay = PublishRelay()
            focusObserver = scheduler.createObserver(Bool.self)
            titleObserver = scheduler.createObserver(String.self)
            channelObserver = scheduler.createObserver(String.self)
            imageURLObserver = scheduler.createObserver(URL.self)

            let input = VideoGalleryItem.Input(
                focus: focusRelay.asDriver(onErrorJustReturn: false)
            )
            
            sut = VideoGalleryItem.ViewModel(data: Video.stub, input: input)
            
            sut.focused.drive(focusObserver).disposed(by: disposeBag)
            sut.title.drive(titleObserver).disposed(by: disposeBag)
            sut.channel.drive(channelObserver).disposed(by: disposeBag)
            sut.imageURL.drive(imageURLObserver).disposed(by: disposeBag)
        }
        
        describe("Given VideoGalleryItemViewModel without focus") {
            context("when created") {
                it("should not have focus by default") {
                    expect(focusObserver.events) == [
                        Recorded.next(0, false)
                    ]
                }
                
                it("should take fields from model") {
                    expect(titleObserver.events) == [
                        Recorded.next(0, Video.stub.titleDefault),
                        Recorded.completed(0)
                    ]
                    expect(channelObserver.events) == [
                        Recorded.next(0, Video.stub.tvShow.titleDefault),
                        Recorded.completed(0)
                    ]
                    expect(imageURLObserver.events) == [
                        Recorded.next(0, Video.stub.galleryImageURL),
                        Recorded.completed(0)
                    ]
                }
            }
            
            context("when focus set to false") {
                beforeEach {
                    focusRelay.accept(false)
                }
                
                it("don't generate another no focus event") {
                    expect(focusObserver.events) == [
                        Recorded.next(0, false)
                    ]
                }
            }
            
            context("when focus set to true") {
                beforeEach {
                    focusRelay.accept(true)
                }
                
                it("should generate focus event") {
                    expect(focusObserver.events) == [
                        Recorded.next(0, false),
                        Recorded.next(0, true)
                    ]
                }
            }
        }
    }
}

