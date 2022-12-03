//
//  ReviewsController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/12/2.
//

import Foundation

class ReviewsController: ObservableObject {
  @Published var reviewsModel: ReviewsModel?
  @Published var myReviews: [ReviewSummary]?
  @Published var faveReviews: [ReviewSummary]?
  
  func fetchReviews(_ userID: Int) {
    fetchMyReview(userID, completion: { reviewsModel in
      self.myReviews = reviewsModel.reviews
    })
    fetchFaveReview(userID, completion: { reviewsModel in
      self.faveReviews = reviewsModel.reviews
    })
  }
  
  private func fetchMyReview(_ userID: Int, completion: @escaping (ReviewsModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getMyReview?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let dashboardDetails = try? JSONDecoder().decode(ReviewsModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(ReviewsController) id: \(userID)")
        return
      }
      
      completion(dashboardDetails)
    }
    task.resume()
  }
  
  private func fetchFaveReview(_ userID: Int, completion: @escaping (ReviewsModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getFavorReview?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let dashboardDetails = try? JSONDecoder().decode(ReviewsModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(ReviewsController) id: \(userID)")
        return
      }
      
      completion(dashboardDetails)
    }
    task.resume()
  }
  
}
