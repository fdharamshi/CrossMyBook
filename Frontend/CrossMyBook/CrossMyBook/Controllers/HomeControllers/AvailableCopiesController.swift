//
//  AvailableCopiesController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/29.
//

import Foundation

class AvailableCopiesController: ObservableObject {
  @Published var availableCopiesModel: AvailableCopiesModel?
  
  func fetchAvailableCopies() {
    fetchData(completion: { availableCopiesModel in
      self.availableCopiesModel = availableCopiesModel
    })
  }
  
  private func fetchData(completion: @escaping (AvailableCopiesModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getAvailableCopies"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let availableCopies = try? JSONDecoder().decode(AvailableCopiesModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(AvailableCopiesController)")
        return
      }
      
      completion(availableCopies)
    }
    task.resume()
  }
}
