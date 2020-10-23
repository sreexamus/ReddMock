//
//  ReddMockManager.swift
//  ReddMock
//
//  Created by sreekanth reddy iragam reddy on 10/14/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation
import UIKit

public typealias MockList = [String]

typealias DWCallback = ((CFNotificationCenter?, UnsafeMutableRawPointer?, CFNotificationName?, UnsafeRawPointer?, CFDictionary?) -> Void)

public class ReddMockManager {
    public static let shared = ReddMockManager()
    public var mockListHanlder: ((MockList) -> ())?
    
    public func setupMockBridge() {
        CrossProcessBridgeCommunication.shared.addObserver(notificationName: "NetworkMock") {
            let item = UIPasteboard.general.items.first { $0["MocksList"] != nil }
            let value = item?["MocksList"] as? Data
            let mocksList = try? (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value!) as! [String])
            if let mocks = mocksList, !mocks.isEmpty {
                self.mockListHanlder?( mocks)
            }
        }
    }
    
    public func postNotification(name: String) {
        CrossProcessBridgeCommunication.shared.postDWNotification(notificationName: name)
    }
}
