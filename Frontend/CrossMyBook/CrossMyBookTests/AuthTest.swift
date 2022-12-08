//
//  AuthTest.swift
//  CrossMyBookTests
//
//  Created by Caifei H on 12/8/22.
//

import XCTest
@testable import CrossMyBook


final class AuthTest: XCTestCase {
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let loginUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/login"
    let testEmail = "caifeih@andrew.cmu.edu"
    let testPassword = "test"
    let invalidPassword = "abcabc"
    
    override func setUp() {
        expectation = expectation(description: "Able to login with correct credentials")
    }
    
    func test_ServerResponse() {
        defer { waitForExpectations(timeout: expired) }
        
        var request = URLRequest(url: URL(string: loginUrl)!)
        request.httpMethod = "POST"
        let postString = "email=\(testEmail)&password=\(testPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidCredential() {
        defer { waitForExpectations(timeout: expired) }
        
        var request = URLRequest(url: URL(string: loginUrl)!)
        request.httpMethod = "POST"
        let postString = "email=\(testEmail)&password=\(invalidPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(AuthModel.self, from: data)
                    XCTAssertEqual(res.msg, "Email or password incorrect")
                    XCTAssertNil(res.user)
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_login() {
        defer { waitForExpectations(timeout: expired) }
        
        var request = URLRequest(url: URL(string: loginUrl)!)
        request.httpMethod = "POST"
        let postString = "email=\(testEmail)&password=\(testPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(AuthModel.self, from: data)
                    print(res)
                    XCTAssertEqual(res.user?.firstName, "Caifei")
                    XCTAssertEqual(res.user?.lastName, "Hong")
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
}
