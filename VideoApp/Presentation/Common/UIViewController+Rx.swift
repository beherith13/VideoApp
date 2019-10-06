//
//  UIViewController+Rx.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var visible: ControlEvent<Bool> {
        let appear = sentMessage(#selector(base.viewWillAppear(_:))).map { _ in true }
        let disappear = sentMessage(#selector(base.viewDidDisappear(_:))).map { _ in false }
        
        return ControlEvent(events: Observable.merge(appear, disappear))
    }
}
