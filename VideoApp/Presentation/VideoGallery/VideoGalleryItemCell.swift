//
//  VideoGalleryItemView.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VideoGalleryItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var disposeBag: DisposeBag!

    func set(model: VideoGalleryItemViewModel) {
        disposeBag = DisposeBag()
       
        model.focused
            .map { $0 ? .white : .clear }
            .drive(contentView.rx.backgroundColor)
            .disposed(by: disposeBag)

        model.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.channel
            .drive(channelLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.imageURL
            .drive(imageView.rx.url)
            .disposed(by: disposeBag)
    }
}
