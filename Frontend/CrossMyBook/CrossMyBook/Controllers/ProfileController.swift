//
//  ProfileController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/10.
//

import Foundation

class ProfileController: ObservableObject {
  @Published var profile: Profile?
  
  init() {
    self.profile = nil
  }
  
  func fetchProfile(_ userID: Int) {
    fetchData(userID, completion: { profile in
      self.profile = profile
    })
  }
  
  private func fetchData(_ userID: Int, completion: @escaping (Profile) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getProfile?user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let profile = try? JSONDecoder().decode(Profile.self, from: data) else {
        print("Error: Couldn't decode data into a result (ProfileController) id: \(userID)")
        return
      }
      
      completion(profile)
    }
    task.resume()
  }
}
