//
//  AppDelegate+ReddMock.swift
//  MockingProject
//
//  Created by sreekanth reddy iragam reddy on 10/14/20.
//  Copyright © 2020 ReddMockProj. All rights reserved.
//

import Foundation
import ReddMock

enum MocksList: String, CaseIterable {
    case getCities
    case getCityDetails
}

extension AppDelegate {
    func setMockFromList(list: [String]) {
        list.forEach { (scenario) in
            switch scenario {
            case MocksList.getCities.rawValue:
                let cityScenario = MockScenarioData(requestData: MockRequestData(url: URL(string: "https://test.com/getcities")!),
                                                    mockFile: "Cities",
                                                    conditionsCheck: [.path])
                RDMockHelper.addMockScenario(cityScenario)
            case MocksList.getCityDetails.rawValue:
                let cityDetailsScenario = MockScenarioData(requestData: MockRequestData(url: URL(string: "https://test.com/getcitidetails")!),
                                                           mockFile: "CityDetails",
                                                           conditionsCheck: [.path])
                RDMockHelper.addMockScenario(cityDetailsScenario)
            default: break
                
            }
            
        }
    }
}
