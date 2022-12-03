//
//  TakeActionOnRequestController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/3/22.
//

import Foundation

class TakeActionOnRequestController {
  
  func takeAction(_ user_id: Int, _ accepted: Int, _ request_id: Int, completion: @escaping (Msg) -> ()) {
    
    let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/takeActionOnRequest")
    guard let requestUrl = url else { fatalError() }
    
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "user_id=\(user_id)&accepted=\(accepted)&request_id=\(request_id)";
    
    // Set HTTP Request Body
    request.httpBody = postString.data(using: String.Encoding.utf8);
    // Perform HTTP Request
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        completion(Msg(msg: "Something went wrong", success: false))
        return
      }
      
      // Decode the JSON here
      guard let actionResponse = try? JSONDecoder().decode(Msg.self, from: data) else {
        print("Error: Couldn't decode data into a result(LoginController)")
        completion(Msg(msg: "Something went wrong", success: false))
        return
      }
      
      completion(actionResponse)
    }
    task.resume()
  }
  
}
