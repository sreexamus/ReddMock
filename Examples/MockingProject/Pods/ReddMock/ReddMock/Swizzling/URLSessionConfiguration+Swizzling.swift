//
//  URLSessionConfiguration+Swizzling.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

extension URLSessionConfiguration {
    @objc class func swizzleDefault() -> URLSessionConfiguration {
        let configuration = swizzleDefault()
        configuration.protocolClasses?.insert(MockHTTPProtocol.self, at: 0)
        print("protocol classes are \(configuration.protocolClasses)")
        return configuration
    }
}
