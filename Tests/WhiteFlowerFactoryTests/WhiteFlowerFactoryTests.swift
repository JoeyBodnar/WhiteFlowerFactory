//
//  WhiteFlowerFactoryTests.swift
//  WhiteFlowerFactoryTests
//
//  Created by Stephen Bodnar on 8/16/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import XCTest
@testable import WhiteFlowerFactory

class WhiteFlowerFactoryTests: XCTestCase {

    var expectation: XCTestExpectation!
    
    override func setUp() {
        expectation = self.expectation(description: "load data")
    }

    override func tearDown() {
        expectation = nil
    }

    func testGetRequestStatusCode() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .get, endPoint: MockProvider.get)
        var statusCode: Int = 0
        WhiteFlower.shared.request(request: request) { response in
            statusCode = (response.dataTaskResponse!.response! as! HTTPURLResponse).statusCode
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertTrue(statusCode == 200)
    }
    
    func testGetDataReqest() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .get, endPoint: MockProvider.get)
        var expectedData: Data!
        WhiteFlower.shared.request(request: request) { response in
            switch response.result {
            case .success(let data): expectedData = data
            case .failure: break
            }
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertTrue(expectedData.count > 0)
    }
    
    func testSerializeGetResponse() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .get, endPoint: MockProvider.get)
        var expectedData: HTTPBinGetResponse! = nil
        WhiteFlower.shared.request(request: request) { response in
            let result = response.serializeTo(type: HTTPBinGetResponse.self)
            switch result {
            case .success(let response): expectedData = response
            case .failure: break
            }
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertTrue(expectedData != nil)
        XCTAssertTrue(expectedData.url == "https://www.httpbin.org/get")
    }
    
    func testGetPlainUrlString() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .get, urlString: "https://httpbin.org/get")
        var expectedData: HTTPBinGetResponse! = nil
        WhiteFlower.shared.request(request: request) { response in
            let result = response.serializeTo(type: HTTPBinGetResponse.self)
            switch result {
            case .success(let response): expectedData = response
            case .failure: break
            }
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 45.0, handler: nil)
        XCTAssertTrue(expectedData != nil)
        XCTAssertTrue(expectedData.url == "https://httpbin.org/get")
    }
    
    func testPostRequestJSONEncoding() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .post, endPoint: MockProvider.post, params: ["parameter": "value"], headers: nil)
        var expectedData: Data! = nil
        var expectedStatusCode: Int = 500
        WhiteFlower.shared.request(request: request) { response in
            switch response.result {
            case .success(let data):
                expectedData = data
                expectedStatusCode = (response.dataTaskResponse!.response! as! HTTPURLResponse).statusCode
                print(try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves))
            case.failure(let error):
                print(error)
            }
            
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 45.0, handler: nil)
        XCTAssertTrue(expectedData != nil)
        XCTAssertTrue(expectedStatusCode == 200)
    }
    
    func testPostReqestURLEncoding() {
        let request: WhiteFlowerRequest = WhiteFlowerRequest(method: .post, endPoint: MockProvider.post, params: ["parameter": "value"], headers: [HTTPHeader(field: HTTPHeaderField.contentType, value: HTTPContentType.urlEncoded.rawValue)])
        var expectedData: Data! = nil
        var expectedStatusCode: Int = 500
        WhiteFlower.shared.request(request: request) { response in
            switch response.result {
            case .success(let data):
                expectedData = data
                expectedStatusCode = (response.dataTaskResponse!.response! as! HTTPURLResponse).statusCode
                print(try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves))
            case.failure(let error):
                print(error)
            }
            
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: 45.0, handler: nil)
        XCTAssertTrue(expectedData != nil)
        XCTAssertTrue(expectedStatusCode == 200)
    }
}
