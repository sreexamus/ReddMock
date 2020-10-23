//
//  RDMockHelper.swift
//  ReddMock
//
//  Created by iragam reddy, sreekanth reddy on 7/30/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

public class RDMockHelper {
     static let shared: RDMockHelper = {
        URLSessionSwizzling.swizzle()
        return RDMockHelper()
    }()
    
    public var mockScenarios: [MockScenarioData] = []
    
    /** Add Mock scenario to the list for Mocking during the network call */
    public static func addMockScenario(_ scenario: MockScenarioData) {
        if !RDMockHelper.shared.mockScenarios.contains(scenario) {
            RDMockHelper.shared.mockScenarios.append(scenario)
        } else {
            print("Mock Scenario already exists")
        }
    }

    /** build HTTP Response with mock file Data and Status Code */
    public static func mockResponse(statusCode: Int, headers: [String: String]? = nil, _ mockFileName: String? = nil) ->  RDMockResponse? {
        guard let file = mockFileName, !file.isEmpty, let responseData = try? RDMockUtil.dataFromFile(file) else {
            return  RDMockResponse(statusCode: statusCode, body: Data(), headers: headers)
        }
        return RDMockResponse(statusCode: statusCode, body: responseData, headers: headers)
    }
}
