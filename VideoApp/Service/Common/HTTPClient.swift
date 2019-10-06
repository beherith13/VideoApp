//
//  Service.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkClient {
    func perform<Response: Decodable>(request: APIRequest) -> Observable<Response>
}

struct HTTPClient: NetworkClient {
    private let session: Session
    private let parser: Parser
    
    init(session: Session = URLSession.shared, parser: Parser = JSONDecoder()) {
        self.session = session
        self.parser = parser
    }
    
    func perform<Response: Decodable>(request: APIRequest) -> Observable<Response> {
        do {
            let request = try request.buildRequest()
            
            return session.data(request: request).map { data in
                return try self.parser.decode(Response.self, from: data)
            }
        } catch {
            return Observable.error(error)
        }
    }
}
