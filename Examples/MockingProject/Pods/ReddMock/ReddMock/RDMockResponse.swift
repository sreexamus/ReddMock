//
//  MockResponse.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public struct RDMockResponse: Equatable {
    public let url: URL?
    public let statusCode: Int
    public let body: Data?
    public let headers: [String: String]?
    
    public init(statusCode: Int, body:Data?, url:URL? = nil, httpVersion: String? = nil, headers:[String: String]? = nil) {
        self.url = url
        self.statusCode = statusCode
        self.body = body
        self.headers = headers
    }
}
