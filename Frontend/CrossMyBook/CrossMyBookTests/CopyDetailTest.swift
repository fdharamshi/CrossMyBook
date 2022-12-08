//
//  CopyTest.swift
//  CrossMyBookTests
//
//  Created by 魏妤庭 on 2022/12/7.
//

import XCTest
@testable import CrossMyBook

final class CopyDetailTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getCopyDetails?"
    let testUserId = 2
    let invalidUserId = -1
    let testCopyId = 9
    let invalidCopyId = -1
    
    override func setUp() {
        expectation = expectation(description: "Able to get the details of a copy")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "user_id=" + String(testUserId) + "&copy_id=" + String(testCopyId))!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(CopyDetailsModel.self, from: data)
                    XCTAssertEqual(res.success, true)
                    XCTAssertEqual(res.title, "It Ends With Us")
                    XCTAssertEqual(res.author, "Colleen Hoover")
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }
        .resume()
    }
    
    
    func test_invalidParameters() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "user_id=" + String(invalidUserId) + "&copy_id=" + String(invalidCopyId))!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "Book Copy Not Found.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
}
