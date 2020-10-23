//
//  MockScenarioData.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public struct MockScenarioData: Equatable {
    public let mockFile: String?
    public let requestData: MockRequestData
    public let response: RDMockResponse?
    public let conditionsCheck: ConditionsCheck
    
    public init(requestData: MockRequestData, mockFile: String? = nil, response: RDMockResponse? = nil, conditionsCheck: ConditionsCheck) {
        self.requestData = requestData
        self.mockFile = mockFile
        self.response = response
        self.conditionsCheck = conditionsCheck
    }
    
    public static func == (lhs: MockScenarioData, rhs: MockScenarioData) -> Bool {
        return lhs.mockFile == rhs.mockFile && lhs.requestData == rhs.requestData && lhs.response == rhs.response && lhs.conditionsCheck == rhs.conditionsCheck
    }
}

