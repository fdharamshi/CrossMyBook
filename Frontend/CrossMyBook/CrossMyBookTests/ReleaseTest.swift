//
//  ReleaseTest.swift
//  CrossMyBookTests
//
//  Created by Caifei H on 12/6/22.
//

import XCTest
@testable import CrossMyBook

final class ReleaseTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookFromISBN?isbn="
    let testISBN = "1682634574"
    let invalidISBN = "1"
    
    override func setUp() {
        expectation = expectation(description: "Able to get book information from ISBN")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + testISBN)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    
    func test_invalidParameters() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + invalidISBN)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "Book not found.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_ParseISBNBookDetail() {
        let bookParser = ReleaseController()
        bookParser.fetchData(testISBN) { (book) in
            XCTAssertEqual(book.title, "Art of Insanity")
            XCTAssertEqual(book.isbn, "1682634574")
            XCTAssertEqual(book.author, "Christine Webb")
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: expired)
    }
}
