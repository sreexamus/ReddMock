//
//  MockingProjectUITests.swift
//  MockingProjectUITests
//
//  Created by sreekanth reddy iragam reddy on 9/9/20.
//  Copyright © 2020 ReddMockProj. All rights reserved.
//

import XCTest
import ReddMock

class MockingProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
         app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

     func testMockingUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        let serializedData = try NSKeyedArchiver.archivedData(withRootObject: ["getCities", "getCityDetails"], requiringSecureCoding: false)
        let info: [[String: Any]] = [["MocksList" : serializedData]]
        UIPasteboard.general.addItems(info)
        app.launch()
        
        ReddMockManager.shared.postNotification(name: "NetworkMock")
        app.buttons["Start"].tap()
        app.staticTexts["Chicago"].tap()
    }
}
