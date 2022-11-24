//
//  MessagingController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import Foundation

class MessagingController: ObservableObject {
  
  @Published var observedCopy: MessagingModel?
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchMessages(_ user1: Int, _ user2: Int) {
    fetchData(user1, user2, completion: { messagingModel in
      self.observedCopy = messagingModel
    })
  }
  
  private func fetchData(_ user1: Int, _ user2: Int, completion: @escaping (MessagingModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getMessages?user1=\(user1)&user2=\(user2)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let messages = try? JSONDecoder().decode(MessagingModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(CopyDetailsController)")
        return
      }
      
      completion(messages)
    }
    task.resume()
  }
  
}
