//
//  CopyToListingTest.swift
//  CrossMyBookTests
//
//  Created by 魏妤庭 on 2022/12/7.
//

import XCTest
@testable import CrossMyBook

final class CopyToListingTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getLatestListingByCopyId?copy_id="
    let testCopyId = 9
    let invalidCopyId = -1
    
    override func setUp() {
        expectation = expectation(description: "Able to get the latest listing of a copy")
    }
    
    func test_validCopyId() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + String(testCopyId))!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    
    func test_invalidCopyId() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + String(invalidCopyId))!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    XCTAssertEqual(res.msg, "Listing not found")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
  
    func test_noCopyId() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    XCTAssertEqual(res.msg, "copyId missing in request.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
}

