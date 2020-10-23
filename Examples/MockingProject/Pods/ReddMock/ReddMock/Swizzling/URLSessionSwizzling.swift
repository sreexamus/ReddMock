//
//  URLSessionSwizzling.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

struct URLSessionSwizzling {
    static func swizzle() {
        URLProtocol.registerClass(MockHTTPProtocol.self)
        let originalSessionConfig = class_getClassMethod(URLSessionConfiguration.self, #selector(getter: URLSessionConfiguration.default))!
        let swizzleSessionConfig = class_getClassMethod(URLSessionConfiguration.self, #selector( URLSessionConfiguration.swizzleDefault))!
        method_exchangeImplementations(originalSessionConfig, swizzleSessionConfig)
    }
}
