//
//  ParserMock.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

@testable import VideoApp

class ParserMock<S: Decodable>: Parser {
    private(set) var lastData: Data?
    let stub: S?

    init(stub: S?) {
        self.stub = stub
    }
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        lastData = data
        
        guard let stub = stub, let typedStub = stub as? T else { throw MockError.test }
        
        return typedStub
    }
}
