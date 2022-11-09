//
//  CopyDetailsController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/7/22.
//

import Foundation

class CopyDetailsController: ObservableObject {
  
  @Published var observedCopy: CopyDetailsModel?
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchCopyDetails(_ copyID: Int) {
    fetchData(copyID, 2, completion: { copyDetailsModel in
      self.observedCopy = copyDetailsModel
    })
  }
  
  private func fetchData(_ copyID: Int, _ userID: Int, completion: @escaping (CopyDetailsModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getCopyDetails?copy_id=\(copyID)&user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let copyDetails = try? JSONDecoder().decode(CopyDetailsModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(CopyDetailsController)")
        return
      }
      
      completion(copyDetails)
    }
    task.resume()
  }
  
}
