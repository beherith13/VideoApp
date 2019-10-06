//
//  VideoGalleryViewModelTests.swift
//  VideoAppTests
//
//  Created by Beherith on 16.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import VideoApp

class VideoGalleryViewModelTests: XCTestCase {
    
    private var sut: VideoGalleryViewModel!
    private var disposeBag: DisposeBag! = DisposeBag()
    private var openedVideo: Video?
    
    private let enableSubject = PublishSubject<Bool>()
    private let focusSubject = PublishSubject<Int?>()
    private let selectSubject = PublishSubject<Void>()
    private let retrySubject = PublishSubject<Void>()
    private let itemsRelay = BehaviorRelay<[VideoGalleryItemViewModel]>(value: [])
    private let errorRelay = BehaviorRelay<String?>(value: nil)
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)

    private let service = VideoLibrary.Mock()
    private let factory = VideoGalleryItem.FactoryMock()
    
    private var itemMocks: [VideoGalleryItem.Mock?] {
        return itemsRelay.value.map { $0 as? VideoGalleryItem.Mock }
    }

    override func setUp() {
        let context = VideoGallery.Context(
            service: service,
            factory: factory
        )
        
        let handlers = VideoGallery.Handlers(
            selected: { [weak self] video in
                self?.openedVideo = video
            }
        )
        
        let input = VideoGallery.Input(
            enable: enableSubject.asSignal(onErrorJustReturn: false),
            focus: focusSubject.asSignal(onErrorJustReturn: nil),
            select: selectSubject.asSignal(onErrorJustReturn: ()),
            retry: retrySubject.asSignal(onErrorJustReturn: ())
        )

        sut = VideoGallery.ViewModel(context: context, input: input, handlers: handlers)
        
        sut.items.drive(itemsRelay).disposed(by: disposeBag)
        sut.error.drive(errorRelay).disposed(by: disposeBag)
        sut.isLoading.drive(isLoadingRelay).disposed(by: disposeBag)
    }

    override func tearDown() {
        sut = nil
        disposeBag = nil
    }

    func testInit() {
        XCTAssertFalse(isLoadingRelay.value)
        XCTAssertNil(errorRelay.value)
        XCTAssertEqual(itemsRelay.value.count, 0)
    }

    func testLoadingOnEnable() {
        enableSubject.onNext(true)
        
        XCTAssertTrue(isLoadingRelay.value)
        service.send(Video.stub)
        XCTAssertFalse(isLoadingRelay.value)
    }
    
    func testLoadingOnError() {
        enableSubject.onNext(true)
        
        XCTAssertTrue(isLoadingRelay.value)
        service.send(API.Error.malformedURL)
        XCTAssertFalse(isLoadingRelay.value)
    }
    
    func testLoadingOnRetry() {
        enableSubject.onNext(true)
        service.send(API.Error.malformedURL)
        retrySubject.onNext(())

        XCTAssertTrue(isLoadingRelay.value)
        service.send(Video.stub)
        XCTAssertFalse(isLoadingRelay.value)
    }
    
    func testItemsOnEnable() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        
        XCTAssertNil(errorRelay.value)
        XCTAssertEqual(itemsRelay.value.count, 2)
    }
    
    func testErrorOnEnable() {
        enableSubject.onNext(true)
        service.send(API.Error.malformedURL)
        
        XCTAssertNotNil(errorRelay.value)
        XCTAssertEqual(itemsRelay.value.count, 0)
    }
    
    func testItemsOnRetry() {
        enableSubject.onNext(true)
        service.send(API.Error.malformedURL)
        retrySubject.onNext(())
        service.send(Video.stub)
        
        XCTAssertNil(errorRelay.value)
        XCTAssertEqual(itemsRelay.value.count, 2)
    }
    
    func testNoFocusAfterInit() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        
        itemMocks.forEach {
            XCTAssertTrue($0?.focusedRelay.value == false)
        }
    }

    func testFocusFirstItem() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        focusSubject.onNext(0)
        
        XCTAssertTrue(itemMocks[0]?.focusedRelay.value == true)
        XCTAssertTrue(itemMocks[1]?.focusedRelay.value == false)
    }

    func testFocusChange() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        focusSubject.onNext(0)
        focusSubject.onNext(1)
        
        XCTAssertTrue(itemMocks[0]?.focusedRelay.value == false)
        XCTAssertTrue(itemMocks[1]?.focusedRelay.value == true)
    }

    func testNoSelectionWithoutFocus() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        selectSubject.onNext(())
        
        XCTAssertNil(openedVideo)
    }
    
    func testSelectionWithFocus() {
        enableSubject.onNext(true)
        service.send(Video.stub)
        focusSubject.onNext(1)
        selectSubject.onNext(())

        XCTAssertEqual(openedVideo, Video.stub[1])
    }
}
