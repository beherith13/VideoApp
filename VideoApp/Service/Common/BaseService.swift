//
//  BaseService.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

class BaseService {
    let client: NetworkClient
    
    init(client: NetworkClient = HTTPClient()) {
        self.client = client
    }
}
