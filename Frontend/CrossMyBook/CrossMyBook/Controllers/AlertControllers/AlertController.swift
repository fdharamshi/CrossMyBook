//
//  AlertController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/10/22.
//

import Foundation

class AlertController: ObservableObject {
  
  @Published var observedCopy: AlertModel?
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchAlertDetails(_ userID: Int) {
    fetchData(userID, completion: { alertModel in
      self.observedCopy = alertModel
    })
  }
  
  private func fetchData(_ userID: Int, completion: @escaping (AlertModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getRequests?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let alerts = try? JSONDecoder().decode(AlertModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(CopyDetailsController)")
        return
      }
      
      completion(alerts)
    }
    task.resume()
  }
  
}
