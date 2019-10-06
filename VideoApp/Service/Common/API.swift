//
//  APIRequest.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import Foundation

enum API {} // namespace

extension API {
    enum Method: String {
        case get = "GET"
    }
    
    enum Error: Swift.Error {
        case malformedURL
    }
}

protocol APIRequest {
    var baseURL: String { get }
    func buildRequest() throws -> URLRequest
}

extension APIRequest {
    private func buildRequest(method: API.Method, path: String) throws -> URLRequest {
        guard let baseURL = URL(string: baseURL) else {
            throw API.Error.malformedURL
        }
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        return request
    }
    
    func get(_ path: String) throws -> URLRequest {
        return try buildRequest(method: .get, path: path)
    }
}
