//
//  ReviewActionTest.swift
//  CrossMyBookTests
//
//  Created by 魏妤庭 on 2022/12/8.
//

import XCTest
@testable import CrossMyBook

final class ReviewActionTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    
    let testUserId = 1
    let testReviewId = 9
  
    // Create Review
    let likeReviewUrl = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/likeReview")
    
    // Delete Review
    let unlikeReviewUrl = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/unlikeReview")

    override func setUp() {
        expectation = expectation(description: "Able to create and delete a review")
    }
    
    func test_likeReview() {
        defer { waitForExpectations(timeout: expired) }
        
        guard let requestUrl = likeReviewUrl else { fatalError() }
        var likeReviewRequest = URLRequest(url: requestUrl)
        likeReviewRequest.httpMethod = "POST"
        let postString = "user_id=\(testUserId)&review_id=\(testReviewId)"
        likeReviewRequest.httpBody = postString.data(using: String.Encoding.utf8)

        URLSession.shared.dataTask(with: likeReviewRequest) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
  
    func test_unlikeReview() {
        defer { waitForExpectations(timeout: expired) }
        
        guard let requestUrl = unlikeReviewUrl else { fatalError() }
        var unlikeReviewRequest = URLRequest(url: requestUrl)
        unlikeReviewRequest.httpMethod = "POST"
        let postString = "user_id=\(testUserId)&review_id=\(testReviewId)"
        unlikeReviewRequest.httpBody = postString.data(using: String.Encoding.utf8)

        URLSession.shared.dataTask(with: unlikeReviewRequest) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }
        .resume()
    }
}
