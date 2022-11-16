//
//  LoginController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/15/22.
//

import Foundation

class LoginController {
  
  func doLogin(_ email: String, _ password: String, completion: @escaping (LoginModel) -> ()) {
    
    let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/login")
    guard let requestUrl = url else { fatalError() }
    
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "email=\(email)&password=\(password)";
    print(postString)
    
    // Set HTTP Request Body
    request.httpBody = postString.data(using: String.Encoding.utf8);
    // Perform HTTP Request
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        completion(LoginModel(msg: "Something went wrong", success: false, user: nil))
        return
      }
      
      // Decode the JSON here
      guard let loginDetails = try? JSONDecoder().decode(LoginModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(LoginController)")
        completion(LoginModel(msg: "Something went wrong", success: false, user: nil))
        return
      }
      
      completion(loginDetails)
    }
    task.resume()
  }
}
