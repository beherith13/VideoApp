//
//  BaseServiceSpec.swift
//  VideoAppTests
//
//  Created by Beherith on 13.11.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxBlocking

@testable import VideoApp

final class HTTPClientSpec: QuickSpec {
    override func spec() {
        var parser: ParserMock<String>!
        var session: SessionMock!
        var request: APIRequestMock!
        var result: BlockingObservable<String>?

        var sut: HTTPClient!
        
        beforeEach {
            parser = ParserMock(stub: "testString")
            session = SessionMock()
            sut = HTTPClient(session: session, parser: parser)
        }
        
        describe("Given HTTPClient") {
            context("correct request performed") {
                beforeEach {
                    request = APIRequestMock()
                    result = sut.perform(request: request).toBlocking()
                }

                context("subscribed to response") {
                    beforeEach {
                        _ = result?.materialize()
                    }
                    
                    it("build request") {
                        expect(request.buildCallCount) == 1
                    }

                    it("pass request to session") {
                        expect(session.lastRequest) == request.stub
                    }

                    it("pass response to parser") {
                        expect(parser.lastData) == session.stub
                    }
                }
                
                it("return parsed result") {
                    expect { try result?.single() } == "testString"
                }
            }
            
            context("failing request performed") {
                beforeEach {
                    request = APIRequestMock(stub: nil)
                    result = sut.perform(request: request).toBlocking()
                }
                
                it("build request") {
                    expect(request.buildCallCount) == 1
                }

                it("return error result") {
                    expect { try result?.first() }.to(throwError(MockError.test))
                }
            }
        }
    }
}


