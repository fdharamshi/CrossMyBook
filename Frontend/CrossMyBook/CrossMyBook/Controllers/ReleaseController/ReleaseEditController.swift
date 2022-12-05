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
    var existing: Bool = true
    var jump = true
    
    
    
    func fetchData(copyId: Int, existing: Bool){
        self.existing = existing
        fetchCopyData(copyId, completion: { bookModel in
          self.book = bookModel
        })
        
        if existing {
            print("existing")
            fetchExistingRelease(copyId)
        }else{
            release.copyId = copyId
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
    
    func updateRelease(userID: Int) -> Bool{
        if existing{
            return editRelease(userID: userID, changed: false, loc: Location())
        }else{
            print("release current - not editing")
            return releaseOnCopy(userID:userID, changed:false,loc:Location())
        }
    }
    
    func updateChangedLocationRelease(userID: Int, loc: Location)->Bool{
        if existing{
            return editRelease(userID: userID, changed:true, loc:loc)
        }else{
            print("release current - not editing")
            return releaseOnCopy(userID:userID,changed:true,loc:loc)
        }
    }
    
    func editRelease(userID: Int, changed: Bool, loc: Location) -> Bool {
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/editRelease")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        var postString = ""
        // HTTP Request Parameters which will be sent in HTTP Request Body
        if (!changed){
            postString = "user_id=\(userID)&copy_id=\(release.copyId)&lat=\(release.lat)&lon=\(release.lon)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        }else{
            postString = "user_id=\(userID)&copy_id=\(release.copyId)&lat=\(loc.latitude)&lon=\(loc.longitude)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        }
            
        
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
    
    func releaseOnCopy(userID: Int,changed: Bool, loc: Location) -> Bool {
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/release")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        var postString = ""
        // HTTP Request Parameters which will be sent in HTTP Request Body
        if (!changed){
            postString = "user_id=\(userID)&copy_id=\(release.copyId)&lat=\(release.lat)&lon=\(release.lon)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        }else{
            postString = "user_id=\(userID)&copy_id=\(release.copyId)&lat=\(loc.latitude)&lon=\(loc.longitude)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        }
        
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
