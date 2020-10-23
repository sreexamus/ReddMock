//
//  ConditionsCheck.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/31/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public struct ConditionsCheck: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    public static let host = ConditionsCheck(rawValue: 1)
    public static let path = ConditionsCheck(rawValue: 2)
    public static let query = ConditionsCheck(rawValue: 4)
    public static let httpMethod = ConditionsCheck(rawValue: 8)
    public static let headers = ConditionsCheck(rawValue: 16)
    public static let httpBody = ConditionsCheck(rawValue: 32)
}
