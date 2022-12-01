//
//  CommunityViewModel.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import Foundation

class CommunityViewModel: ObservableObject {
    
    @Published var reviewsData: Reviews!
    @Published var userBooks: [crossedBook]!
    
    let urlPrefix = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000"
//    let urlPrefix = "http://127.0.0.1:8000"
    func getReviews() -> [Review] {
        if (reviewsData != nil) {
            return reviewsData!.reviews
        }
        return []
    }
    
    func getUserBooks() -> [crossedBook] {
        if (userBooks != nil) {
            return userBooks
        } else {
            return []
        }
    }
    
    func createReview(userId: Int, bookId: Int, content: String, stars: Int, completion: @escaping ((Bool, String)) -> ()) {
        let url = URL(string: urlPrefix + "/createReview")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "user_id=\(userId)&book_id=\(bookId)&content=\(content)&stars=\(stars)"
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion((false, error.localizedDescription))
                return
            }
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] else {
                print("Create review failed!")
                completion((false, "Network Error"))
                return
            }
//            print(jsonResponse)
            let res = jsonResponse["success"] as? Int
            let msg = jsonResponse["msg"] as! String
            if (res == 0) {
                completion((false, msg))
                return
            }
            completion((true, "Success!"))
        }
        task.resume()
    }
    
    func likeReview(userId: Int, reviewId: Int, completion: @escaping ((Bool, String)) -> ()) {
        let url = URL(string: urlPrefix + "/likeReview")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "user_id=\(userId)&review_id=\(reviewId)"
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion((false, error.localizedDescription))
                return
            }
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] else {
                print("Like review failed!")
                completion((false, "Network Error"))
                return
            }
            let res = jsonResponse["success"] as? Int
            let msg = jsonResponse["msg"] as! String
            if (res == 0) {
                completion((false, msg))
                return
            }
            completion((true, "Success!"))
        }
        task.resume()
    }
    
    func unlikeReview(userId: Int, reviewId: Int, completion: @escaping ((Bool, String)) -> ()) {
        let url = URL(string: urlPrefix + "/unlikeReview")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "user_id=\(userId)&review_id=\(reviewId)"
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion((false, error.localizedDescription))
                return
            }
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] else {
                print("Unlike review failed!")
                completion((false, "Network Error"))
                return
            }
            let res = jsonResponse["success"] as? Int
            let msg = jsonResponse["msg"] as! String
            if (res == 0) {
                completion((false, msg))
                return
            }
            completion((true, "Success!"))
        }
        task.resume()
    }
}
