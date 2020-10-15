//
//  ReddMockManager.swift
//  ReddMock
//
//  Created by sreekanth reddy iragam reddy on 10/14/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation
import UIKit


typealias DWCallback = ((CFNotificationCenter?, UnsafeMutableRawPointer?, CFNotificationName?, UnsafeRawPointer?, CFDictionary?) -> Void)
enum MocksList: String, CaseIterable {
    case getCities
    case getCityDetails
}

public class ReddMockManager {
    public static let shared = ReddMockManager()
    public func setupMockBridge() {
        CrossProcessBridgeCommunication.shared.addObserver(notificationName: "NetworkMock") {
            let item = UIPasteboard.general.items.first { $0["MocksList"] != nil }
            let value = item?["MocksList"] as? Data
            let mocksList = try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value!) as! [String])
            self.setMockFromList(list: mocksList!)
        }
    }

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
