//
//  SearchController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/4/22.
//

import Foundation

class SearchController: ObservableObject {
  @Published var searchModel: SearchModel?
  
  func fetchSearcheditems(_ query: String) {
    fetchData(query, completion: { searchModel in
      self.searchModel = searchModel
    })
  }
  
  private func fetchData(_ query: String, completion: @escaping (SearchModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/search?query=\(query)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let searchModel = try? JSONDecoder().decode(SearchModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(AvailableCopiesController)")
        return
      }
      
      completion(searchModel)
    }
    task.resume()
  }
}
