//
//  DashboardController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/25.
//

import Foundation

class DashboardController: ObservableObject {
  @Published var dashboardModel: DashboardModel?
  @Published var displayBooks: [DashboardBooks]?
  
  func fetchUserBooks(_ userID: Int) {
    fetchData(userID, completion: { dashboardModel in
      self.dashboardModel = dashboardModel
      self.displayBooks = dashboardModel.currentBooks
    })
  }
  
  func changeDisplayBooks(_ displayFlag: String) {
    if (displayFlag == "current") {
      self.displayBooks = self.dashboardModel?.currentBooks
    }
    if (displayFlag == "history") {
      self.displayBooks = self.dashboardModel?.historyBooks
    }
  }
  
  private func fetchData(_ userID: Int, completion: @escaping (DashboardModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookByUserId?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let dashboardDetails = try? JSONDecoder().decode(DashboardModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(DashboardController) id: \(userID)")
        return
      }
      
      completion(dashboardDetails)
    }
    task.resume()
  }
}
