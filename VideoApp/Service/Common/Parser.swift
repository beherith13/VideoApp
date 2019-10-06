//
//  Parser.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

protocol Parser {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: Parser { }
