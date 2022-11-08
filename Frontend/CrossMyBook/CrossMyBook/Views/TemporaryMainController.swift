//
//  TemporaryMainController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import Foundation

class TemporaryMainController: ObservableObject {
  
  @Published var observedCopy: TemporaryMainModel?
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchDetails() {
    fetchData(completion: { temporaryMainModel in
      self.observedCopy = temporaryMainModel
    })
  }
  
  private func fetchData(completion: @escaping (TemporaryMainModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/main"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let main = try? JSONDecoder().decode(TemporaryMainModel.self, from: data) else {
        print("Error: Couldn't decode data into a result")
        return
      }
      
      completion(main)
    }
    task.resume()
  }

}
