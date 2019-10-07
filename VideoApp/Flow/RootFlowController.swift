//
//  RootFlowController.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit

class RootFlowController {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        openVideoGallery()
    }
    
    private func openVideoGallery() {
        let viewController: VideoGalleryViewController = Storyboard.Main.viewController(withIdentifier: .videoGallery)

        let context = VideoGallery.Context(
            service: VideoLibrary.Service(),
            factory: VideoGalleryItem.Factory()
        )
        let handlers = VideoGallery.Handlers(
            selected: openVideoDetails
        )

        viewController.viewModelFactory = VideoGallery.Factory(context: context, handlers: handlers)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func openVideoDetails(video: Video) {
        print("Open details for \"\(video.titleDefault)\"")
    }
}
