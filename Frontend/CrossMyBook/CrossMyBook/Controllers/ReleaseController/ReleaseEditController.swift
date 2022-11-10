//
//  ReleaseController.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation

class ReleaseEditController: ObservableObject {
    @Published var book: ISBNBook?
    @Published var release: Release = Release()
    var jump = true;
//    let loc: Location = Location()
    
    func fetchData(copyId: Int, existing: Bool){
        // MARK: user default
        fetchCopyData(copyId, completion: { bookModel in
          self.book = bookModel
        })
        
        if existing {
            print("existing")
            fetchExistingRelease(copyId)
        }
        
    }
    
    func fetchExistingRelease(_ copyId: Int){
        let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getLatestListingByCopyId?copy_id=\(copyId)"
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { [self] (data, response, error) in
            guard let data = data else {
                print("Error: No data to decode")
                return
            }
            
            // Decode the JSON here
            guard let existingRelease = try? JSONDecoder().decode(ExistingRelease.self, from: data) else {
                print("Error: Couldn't decode data into a result(ReleaseContoller2)")
                return
            }
            self.release.note = existingRelease.note
            self.release.shipping = existingRelease.shipping
            self.release.distance = existingRelease.distance
            self.release.condition = existingRelease.condition
            self.release.copyId = copyId
            self.release.lat = existingRelease.lat
            self.release.lon = existingRelease.lon
        }
        task.resume()
    }
    
    private func fetchCopyData(_ copyID: Int, completion: @escaping (ISBNBook) -> ()) {
      let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookByCopyId?copy_id=\(copyID)"
      let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }
        
        // Decode the JSON here
        guard let book = try? JSONDecoder().decode(ISBNBook.self, from: data) else {
          print("Error: Couldn't decode data into a result(CopyDetailsController) id: \(copyID)")
          return
        }
        
        completion(book)
      }
      task.resume()
    }
    
    func updateRelease(userID: Int) -> Bool {
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/editRelease")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        // MARK: UserID hard code to 4
        let postString = "user_id=\(userID)&copy_id=\(release.copyId)&lat=\(release.lat)&lon=\(release.lon)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                self.jump = false
                print("Error: No data to decode")
                return
            }
            
            // Decode the JSON here
            guard let msg = try? JSONDecoder().decode(ReleaseMsg.self, from: data) else {
                self.jump = false
                print("Error: Couldn't decode data into a result(ReleaseContoller2)")
                return
            }
        }
        task.resume()
        return self.jump
    }
}
