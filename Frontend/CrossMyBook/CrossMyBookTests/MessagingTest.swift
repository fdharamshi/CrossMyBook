//
//  MessagingTest.swift
//  CrossMyBookTests
//
//  Created by Caifei H on 12/8/22.
//

import XCTest
@testable import CrossMyBook

final class MessagingTest: XCTestCase {
    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    
    let conversationUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getConversations?user_id="
    let messageUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getMessages?"
    
    let testUserId = "1"
    let testSecondUserId = "2"

    override func setUp() {
        expectation = expectation(description: "Able to get message data")
    }
    
    func test_ParseConversation() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: conversationUrl + testUserId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(ConversationModel.self, from: data)
                    print(res.conversations.count)
                    XCTAssertGreaterThan(res.conversations.count, 1)
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_ParseMessage() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: messageUrl + "user1=\(testUserId)&user2=\(testSecondUserId)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(MessagingModel.self, from: data)
                    print(res.messages)
                    XCTAssertGreaterThan(res.messages.count, 1)
                    XCTAssertEqual(res.success, true)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
}
