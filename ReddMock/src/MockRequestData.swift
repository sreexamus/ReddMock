//
//  MockInputData.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public struct MockRequestData: Equatable {

    public let url: URL
    public let params: [String: Any]?
    public let headers: [String: String]?
    public let httpBody: Data?
    public let host: String?
    
    public init(url: URL, params: [String: Any]? = nil, headers: [String: String]? = nil, host: String? = nil) {
        self.url = url
        self.params = params
        self.headers = headers
        self.host = host
        if let params = params {
            print("params converted to http body")
            self.httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: [JSONSerialization.WritingOptions()])
        } else {
            self.httpBody = nil
        }
    }
    
    public static func == (lhs: MockRequestData, rhs: MockRequestData) -> Bool {
        var isParams = true
        if let rhsparams = rhs.params,let lhsparams = lhs.params {
            isParams = NSDictionary(dictionary: rhsparams).isEqual(to: lhsparams)
        }
        
        var isHeaders = true
        if let rhsHeaders = rhs.headers,let lhsHeaders = lhs.headers {
            isHeaders = NSDictionary(dictionary: rhsHeaders).isEqual(to: lhsHeaders)
        }
        
        return lhs.url == rhs.url && isParams && isHeaders && lhs.httpBody  == rhs.httpBody
    }
}
