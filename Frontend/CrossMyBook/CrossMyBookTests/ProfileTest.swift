//
//  ProfileTest.swift
//  CrossMyBookTests
//
//  Created by Azathoth on 12/7/22.
//

import XCTest
@testable import CrossMyBook

// The end points test in ProfileTest
// path(‘getBookByUserId’, book.get_books_by_user_id),
// path(‘getMyReview’, profile.get_my_reviews),
// path(‘getFavorReview’, profile.get_favor_reviews),
// path(‘getProfile’, profile.getProfile),

final class ProfileTest: XCTestCase {

    let expired: TimeInterval = 10
    var expectation: XCTestExpectation!
    let getProfileUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getProfile?user_id="
    let getMyReviewUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getMyReview"
    let getFavorReviewUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getFavorRview"
    let getBookByUserIdUrl = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookByUserId"

    let userId = "1"
    let testUserId = 1
    let invalidUserId = "0"
    
    override func setUp() {
        expectation = expectation(description: "Able to get user information by user id")
    }
    
    // MARK: getProfile
    func test_ServerResponse_getProfile() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getProfileUrl + userId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidParameters_getProfile() {
        defer { waitForExpectations(timeout: expired) }
        
        let url = URL(string: getProfileUrl + invalidUserId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "User not logged in.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
//    func test_ParseProfile() {
//        let pc = ProfileController()
//        pc.fetchData(testUserId) { (profile) in
//            XCTAssertEqual(profile.lastName, "Dharamshi")
//            XCTAssertEqual(profile.firstName, "Femin")
//            XCTAssertEqual(profile.success, true)
//            XCTAssertEqual(profile.email, "fkd@andrew.cmu.edu")
//            self.expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: expired)
//    }
    
    func test_ParseProfile() {
        let pc = ProfileController()
        pc.fetchProfile(testUserId)
        sleep(10)
        XCTAssertNotNil(pc.profile)
        XCTAssertEqual(pc.profile?.lastName, "Dharamshi")
        XCTAssertEqual(pc.profile?.firstName, "Femin")
        XCTAssertEqual(pc.profile?.success, true)
        XCTAssertEqual(pc.profile?.email, "fkd@andrew.cmu.edu")
        self.expectation.fulfill()
        
        
        waitForExpectations(timeout: expired)
    }
    
    // MARK: getMyReview
    func test_ServerResponse_getMyReview() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getMyReviewUrl + "?user_id=" + userId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidParameters_getMyReview() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getMyReviewUrl)!
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

//    func test_ParseMyReview() {
//        let rc = ReviewsController()
//        rc.fetchMyReview(testUserId) { (reviews) in
//            XCTAssertEqual(reviews.success, true)
//            XCTAssertEqual(reviews.msg, "Success!")
//            self.expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: expired)
//    }
    
    // MARK: getFavorReview
    func test_ServerResponse_getFavorReview() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getFavorReviewUrl + "?user_id=" + userId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidParameters_getFavorReview() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getFavorReviewUrl)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "User not logged in.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_ParseMyReview() {
        let rc = ReviewsController()
        rc.fetchReviews(testUserId)
        sleep(10)
        XCTAssertNotNil(rc.myReviews)
        XCTAssertNotNil(rc.faveReviews)
        XCTAssertNotEqual(rc.myReviews?.count, 0)
        self.expectation.fulfill()
        waitForExpectations(timeout: expired)
    }
    
//    func test_ParseMyFavorReview() {
//        let rc = ReviewsController()
//        rc.fetchFaveReview(testUserId) { (reviews) in
//            XCTAssertEqual(reviews.success, true)
//            XCTAssertEqual(reviews.msg, "Success!")
//            self.expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: expired)
//    }
    
    // MARK: getBookByUserId
    
    func test_ServerResponse_getBookByUserId() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getBookByUserIdUrl + "?user_id=" + userId)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
        .resume()
    }
    
    func test_invalidParameters_getBookByUserId() {
        defer { waitForExpectations(timeout: expired) }
        let url = URL(string: getBookByUserIdUrl)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Msg.self, from: data)
                    print(res)
                    XCTAssertEqual(res.msg, "User not found.")
                    XCTAssertEqual(res.success, false)
                } catch let error {
                    print(error)
                }
            }
            self.expectation.fulfill()
        }.resume()
    }
    
    func test_ParseBookByUserId() {
        let dc = DashboardController()
        dc.fetchUserBooks(testUserId)
        sleep(5)
        XCTAssertNotNil(dc.dashboardModel)
        XCTAssertNotNil(dc.displayBooks)
        self.expectation.fulfill()
        waitForExpectations(timeout: expired)
    }

    
}
