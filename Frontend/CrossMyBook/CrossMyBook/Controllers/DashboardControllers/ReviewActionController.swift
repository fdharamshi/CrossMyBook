//
//  ReviewActionController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/12/2.
//

import Foundation

class ReviewActionController: ObservableObject {
  func unlikeReview(userID: Int, reviewID: Int) {

    let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/unlikeReview")
    guard let requestUrl = url else { fatalError() }
    
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "user_id=\(userID)&review_id=\(reviewID)"
    
    // Set HTTP Request Body
    request.httpBody = postString.data(using: String.Encoding.utf8)

    // Perform HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard data != nil else {
            print("Error: No data to decode")
            return
        }
    }
    
    task.resume()
  }
}
