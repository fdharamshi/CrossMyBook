//
//  BookTest.swift
//  CrossMyBookTests
//  This testsuit includes tests for Book Detail page and Home page
//  Created by Caifei H on 12/4/22.
//

import XCTest
@testable import CrossMyBook

final class BookTest: XCTestCase {
    
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let getBookUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookDetails?book_id="
    let getBookForMainUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/main"
    let getAvailableCopiesUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getAvailableCopies"
    
    let testBookId = "3"
    let invalidBookId = "1"
    
    override func setUp() {
        expectation = expectation(description: "Able to parse the book data received")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: getBookUrl + testBookId)!
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
        
        let url = URL(string: getBookUrl + invalidBookId)!
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
    
    func test_booksForMainPage() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: getBookForMainUrl)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(TemporaryMainModel.self, from: data)
                    XCTAssertGreaterThan(res.allBooks.count, 1)
                    XCTAssertGreaterThan(res.allCopies.count, 1)
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_availableCopies() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: getAvailableCopiesUrl)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(AvailableCopiesModel.self, from: data)
                    print(res)
                    XCTAssertGreaterThan(res.availableCopies.count, 1)
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    
}
