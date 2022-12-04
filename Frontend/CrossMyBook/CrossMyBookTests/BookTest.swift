//
//  BookTest.swift
//  CrossMyBookTests
//
//  Created by Caifei H on 12/4/22.
//

import XCTest
@testable import CrossMyBook

final class BookTest: XCTestCase {
    
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookDetails?book_id="
    let testBookId = "3"
    let invalidBookId = "1"
    
    override func setUp() {
        expectation = expectation(description: "Able to parse the book data received")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: urlString + testBookId)!
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
        
        let url = URL(string: urlString + invalidBookId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "Book Not Found.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_ParseBookDetail() {
        let bookParser = BookParser()
        bookParser.fetchBookDetails(bookId: testBookId) { (book) in
            XCTAssertEqual(book.title, "The Song of Achilles")
            XCTAssertEqual(book.author, "Madeline Miller")
            self.expectation.fulfill()
        }
        
        waitForExpectations(timeout: expired)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
