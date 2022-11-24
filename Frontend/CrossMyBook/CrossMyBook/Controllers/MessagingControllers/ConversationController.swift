//
//  ConversationController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import Foundation

class ConversationController: ObservableObject {
  
  @Published var observedCopy: ConversationModel?
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchConversations(_ userID: Int) {
    fetchData(userID, completion: { conversationModel in
      self.observedCopy = conversationModel
    })
  }
  
  private func fetchData(_ userID: Int, completion: @escaping (ConversationModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getConversations?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let conversations = try? JSONDecoder().decode(ConversationModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(CopyDetailsController)")
        return
      }
      
      completion(conversations)
    }
    task.resume()
  }
  
}
