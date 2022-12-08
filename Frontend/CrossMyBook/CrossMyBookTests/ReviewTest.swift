//
//  ReviewTest.swift
//  CrossMyBookTests
//
//  Created by Caifei H on 12/4/22.
//

import XCTest
@testable import CrossMyBook

final class ReviewTest: XCTestCase {
    
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/"
    let validUserId = "1"
    let validReviewType = "1"
    let relatedReviewType = "2"
    let invalidReviewType = "0"
    
    
    override func setUp() {
        expectation = expectation(description: "Able to get reviews by user id and review type")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "getReviews?user_id="+validUserId+"&review_type="+validReviewType)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    func test_ServerResponse2() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "getReviews?user_id="+validUserId+"&review_type="+relatedReviewType)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidReviewType() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "getReviews?user_id="+validUserId+"&review_type="+invalidReviewType)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "Invalid review type")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_invalidUserId() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + "getReviews?review_type="+validReviewType)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "User is not logged in.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }

    

}
