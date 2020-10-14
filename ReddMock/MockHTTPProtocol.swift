//
//  URLSession+Swizzling.swift
//  ApplicationUITestingUITests
//
//  Created by sreekanth reddy iragam reddy on 7/24/20.
//  Copyright © 2020 com.test.Sample. All rights reserved.
//

import Foundation

class MockHTTPProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let url = request.url else { return false }
        let urlPath = url.path
        print("#### urlPath ..... \(urlPath)")
        let isRequestHandle = RDMockHelper.shared.mockScenarios.contains { scenario -> Bool in
            scenario.requestData.url.absoluteString.contains(urlPath)
        }
        print("#### isRequestHandle ..... \(isRequestHandle)")
        return isRequestHandle
    }
     
     override class func canonicalRequest(for request: URLRequest) -> URLRequest {
         return request
     }
     
     override  func startLoading() {
        var mockResponse: RDMockResponse? = nil
        var mockData: Data?
        guard let mockScenario = compareReques(request: request) else {
            print("error found no match")
            handleNoMatchFound()
            return
        }
        
        if let response = mockScenario.response {
            mockResponse = response
            mockData = response.body
        } else if let mockFineName = mockScenario.mockFile, let mockRes = getMockResponse(mockFineName),  let mockDat =  mockRes.body  {
            mockResponse = mockRes
            mockData = mockDat
        }
        
        let httpResponse = HTTPURLResponse(url: mockResponse?.url ?? self.request.url!, statusCode: mockResponse?.statusCode ?? 200, httpVersion: nil , headerFields: mockResponse?.headers)!
         
         self.client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
         client?.urlProtocol(self, didLoad: mockData ?? Data())
         client?.urlProtocolDidFinishLoading(self)
     }
    
    override func stopLoading() {
    }
}

extension MockHTTPProtocol {
    func compareReques(request: URLRequest) -> MockScenarioData? {
        let mockScenario = RDMockHelper.shared.mockScenarios.filter { scenario in
            var isCondititon = true
            if scenario.conditionsCheck.contains(.host) {
                let host = request.url?.host
                let isTrue = host == scenario.requestData.host
                isCondititon = isCondititon && isTrue
                print("Testing Host .. \(isCondititon)")
            }
            
            if scenario.conditionsCheck.contains(.path) {
                let path = request.url?.path
                let isTrue = path == scenario.requestData.url.path
                isCondititon = isCondititon && isTrue
                print("Testing path .. \(isCondititon)")
            }
            
            if scenario.conditionsCheck.contains(.query),
                let query = request.url?.query {
                let isTrue = query == scenario.requestData.url.query
                isCondititon = isCondititon && isTrue
                print("Testing path .. \(isCondititon)")
            }
            
            
            if scenario.conditionsCheck.contains(.httpBody),
                let httpBodyStream = request.httpBodyStream,
                request.httpMethod == "POST" {
                let httpBody = Data(reading: httpBodyStream)
                let isTrue = httpBody == scenario.requestData.httpBody
                isCondititon = isCondititon && isTrue
                print("Testing httpBody .. \(isCondititon)")
            }
            
            if scenario.conditionsCheck.contains(.headers) {
                let allHeaders = request.allHTTPHeaderFields
                var expectedHeader: [String: String] = [:]
                scenario.requestData.headers?.forEach { reqHeader in
                    allHeaders?.forEach { (header) in
                        if reqHeader.key == header.key && reqHeader.value == header.value {
                            expectedHeader[header.key] = header.value
                        }
                    }
                }
                
                let isTrue = expectedHeader.count == scenario.requestData.headers?.count
                isCondititon = isCondititon && isTrue
                print("Testing headers .. \(isCondititon)")
            }
            
            return isCondititon
        }
        
        return mockScenario.first
    }
    
    func getMockResponse(_ mockFileName: String) ->  RDMockResponse? {
        return RDMockHelper.mockResponse(statusCode: 200, headers: nil, mockFileName)
    }
    
    func handleNoMatchFound() {
        let httpResponse = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)
        self.client?.urlProtocol(self, didReceive: httpResponse!, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: Data())
        client?.urlProtocolDidFinishLoading(self)
        return
    }
}

    




