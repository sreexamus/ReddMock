//
//  ReddMockTests.swift
//  ReddMockTests
//
//  Created by iragam reddy, sreekanth reddy on 7/31/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import ReddMock
import XCTest

class ReddMockTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUrlHost() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: nil,
                                                                                             headers: nil),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: .host))
        
        let responseExpectation = self.expectation(description: "Google response received")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 200, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testUrlPath() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: nil,
                                                                                             headers: nil),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: .path))
        
        let responseExpectation = self.expectation(description: "Google response received")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 200, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testUrlPathFailure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: nil,
                                                                                             headers: nil),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: .path))
        
        let responseExpectation = self.expectation(description: "Google response received")
        URLSession.shared.dataTask(with: URL(string: "https://google.com/samplecode")!) { (data, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 404, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testBody() throws {
        let bodyParams = ["name": "google"]
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: bodyParams,
                                                                                             headers: nil),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: [.httpBody, .path]))
        
        let responseExpectation = self.expectation(description: "Google response received")
        var request = URLRequest(url: url)
        let httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: [JSONSerialization.WritingOptions()])
        request.httpMethod = "POST"
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (url, response, error) in
            
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 200, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testHeaderAndBody() throws {
        let bodyParams = ["name": "google"]
        let headers = ["userAgent": "iPhone iOS 12.0"]
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: bodyParams,
                                                                                             headers: headers),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: [.httpBody, .headers]))
        
        let responseExpectation = self.expectation(description: "Google response received")
        var request = URLRequest(url: url)
        let httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: [JSONSerialization.WritingOptions()])
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.allHTTPHeaderFields?["userAgent"] = "iPhone iOS 12.0"
        URLSession.shared.dataTask(with: request) { (url, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 200, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testHeaderAndBodyFailure() throws {
        let bodyParams = ["name": "google"]
        let headers = ["userAgent": "iPhone iOS 12.0"]
        guard let url = URL(string: "https://google.com/234/samplecode") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url: url,
                                                                                             params: bodyParams,
                                                                                             headers: headers),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: [.httpBody, .headers]))
        
        let responseExpectation = self.expectation(description: "Google response received")
        var request = URLRequest(url: url)
        let httpBody = try? JSONSerialization.data(withJSONObject: ["name": "facebook"], options: [JSONSerialization.WritingOptions()])
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.allHTTPHeaderFields?["userAgent"] = "iPhone iOS 12.0"
        URLSession.shared.dataTask(with: request) { (url, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 404, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
    
    func testHeaderAndQueryParams() throws {
        let headers = ["userAgent": "iPhone iOS 12.0"]
        guard let url = URL(string: "https://google.com/234/samplecode?name=google") else { return }
        RDMockHelper.addMockScenario(MockScenarioData.init(requestData: MockRequestData.init(url:url,
                                                                                             headers: headers),
                                                           mockFile: "GoogleMock",
                                                           response: nil,
                                                           conditionsCheck: [.headers, .query]))
        
        let responseExpectation = self.expectation(description: "Google response received")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields?["userAgent"] = "iPhone iOS 12.0"
        URLSession.shared.dataTask(with: request) { (url, response, error) in
            let responseUrl = response as? HTTPURLResponse
            XCTAssertEqual(responseUrl?.statusCode, 200, "Call failed")
            responseExpectation.fulfill()
        }.resume()
        self.wait(for: [responseExpectation], timeout: 5)
    }
}
