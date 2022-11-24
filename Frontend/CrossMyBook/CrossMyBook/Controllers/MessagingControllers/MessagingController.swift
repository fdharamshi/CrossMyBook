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
  
  func sendMessage(sender: Int, receiver: Int, message:String) {
      
      let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/sendMessage")
      guard let requestUrl = url else { fatalError() }
      
      // Prepare URL Request Object
      var request = URLRequest(url: requestUrl)
      request.httpMethod = "POST"
      
      // HTTP Request Parameters which will be sent in HTTP Request Body
      let postString = "sender=\(sender)&receiver=\(receiver)&message=\(message)";
      
      // Set HTTP Request Body
      request.httpBody = postString.data(using: String.Encoding.utf8);
      // Perform HTTP Request
      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard data != nil else {
              print("Error: No data to decode")
              return
          }
        
        self.fetchMessages(sender, receiver)
      }
      task.resume()
  }
  
}
