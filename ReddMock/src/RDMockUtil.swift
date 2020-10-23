//
//  NetworkMockUtil.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public struct RDMockUtil {
    static func dataFromFile(_ filename: String) throws -> Data {
        
        guard let path = Bundle.allBundles.first(where: { $0.url(forResource: filename, withExtension: "json") != nil })?.url(forResource: filename, withExtension: "json") else {
            throw ErrorResult.error("File Not found")
        }
        
        let data = try Data(contentsOf: path)
        print("the data from json file \(data)")
        return data
    }
}

enum ErrorResult: Error {
    case error(String)
    case warning(String)
    case info(String, String)
    case parse(String)
}
