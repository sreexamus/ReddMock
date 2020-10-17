//
//  CrossProcessBridgeCommunicationDelegate.swift
//  ApplicationReddMock
//
//  Created by iragam reddy, sreekanth reddy on 8/3/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation
import UIKit

protocol CrossProcessBridgeCommunicationDelegate {
    func addObserver(notificationName: String, mockHandler:  @escaping () -> Void)
    func postDWNotification(notificationName: String)
    func removeObserver(notificationName: String)
}

public final class CrossProcessBridgeCommunication: CrossProcessBridgeCommunicationDelegate {
    
    public static let shared = CrossProcessBridgeCommunication()
    var dwNotificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
    var mockHandler: (() -> Void)?
    
    private var rawPointerToSelf: UnsafeRawPointer {
         return UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
     }
    
    func addObserver(notificationName: String, mockHandler: @escaping () -> Void) {
        self.mockHandler = mockHandler
        CFNotificationCenterAddObserver(dwNotificationCenter,
                                        rawPointerToSelf,
                                        { (_, observer, notificationName, _, _) in
                                            guard let observer = observer else {
                                                      return
                                              }
                                              let crossProcess = Unmanaged<CrossProcessBridgeCommunication>.fromOpaque(observer).takeUnretainedValue()
                                            print("notified...")
                                            crossProcess.mockHandler?()
                                        },
                                        notificationName as CFString,
                                        nil,
                                        .deliverImmediately)
    }
    
    public func postDWNotification(notificationName: String) {
        CFNotificationCenterPostNotification(dwNotificationCenter,
                                             CFNotificationName(notificationName as CFString),
                                             nil,
                                             nil,
                                             true)
    }
    
    func removeObserver(notificationName: String) {
        CFNotificationCenterRemoveObserver(dwNotificationCenter,
                                           rawPointerToSelf,
                                            CFNotificationName(notificationName as CFString),
                                           nil)
    }
}
