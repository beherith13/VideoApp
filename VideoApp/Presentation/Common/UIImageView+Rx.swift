//
//  UIImage+Rx.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: UIImageView {
    public var url: Binder<URL?> {
        return Binder(base) { imageView, resource in
            imageView.kf.setImage(with: resource)
        }
    }
}
