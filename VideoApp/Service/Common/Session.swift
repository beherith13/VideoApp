//
//  Session.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

protocol Session {
    func data(request: URLRequest) -> Observable<Data>
}

extension URLSession: Session {
    func data(request: URLRequest) -> Observable<Data> {
        return rx.data(request: request)
    }
}
