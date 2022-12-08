//
//  SearchTest.swift
//  CrossMyBookTests
//
//  Created by 魏妤庭 on 2022/12/8.
//

import XCTest
@testable import CrossMyBook

final class SearchTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/search?query="
    let testQuery = ""
    
    override func setUp() {
        expectation = expectation(description: "Able to search books with a query string")
    }
    
    func test_searchResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + testQuery)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(SearchModel.self, from: data)
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
