//
//  ReleaseController.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation

class ReleaseController: ObservableObject {
    @Published var book: ISBNBook?
    @Published var release: Release = Release()
    @Published var copyId: Int = 0
    @Published var releaseId: Int = 0
    var jump = true;
    let loc: Location = Location()
    
  func fetchBookDetails(isbn: String, completionHandler: @escaping (Bool)->()){
        fetchData(isbn, completion: { bookModel in
          if(bookModel == nil) {
            completionHandler(false)
          } else {
            self.book = bookModel
            completionHandler(true)
          }
        })
        if book != nil {
            print(book!.title)
        }
    }
    
    func fetchData(_ isbn: String, completion: @escaping (ISBNBook?) -> ()){
        let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookFromISBN?isbn=\(isbn)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                print("Error: No data to decode")
                completion(nil)
              return
            }
            
            // Decode the JSON here
            guard let book = try? JSONDecoder().decode(ISBNBook.self, from: data) else {
                print("Error: Couldn't decode data into a result(ReleaseContoller2)")
                completion(nil)
              return
            }
            print(book.title)
            completion(book)
        }
        task.resume()
    }
    
    
    func inputZipCode(zip:String){
        release.zipCode = Int(zip) ?? 0
    }
    
    func generateTitle() -> String {
        let message = "Your location is at:\n(\(self.loc.latitude), \(self.loc.longitude))"
        return message
    }
    func test(){
        print(book?.bookID ?? 0)
        print(loc.latitude, loc.longitude)
        print(release.condition)
        print(release.shipping)
        print(release.distance)
        print(release.note)
    }
    
    func createRelease(userID: Int) -> Bool {
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/releaseNew")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        // MARK: UserID hard code to 4
        let postString = "user_id=\(userID)&book_id=\(book?.bookID ?? 0)&lat=\(loc.latitude)&lon=\(loc.longitude)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        print(postString)
        //        let postString = "user_id=1&book_id=3&lat=0&lon=0&book_condition=Good&charges=Incurrent by the Requester&max_distance=Same City&note=someNotes";
        
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
            self.copyId = msg.copy_id
            self.releaseId = msg.release_id
        }
        task.resume()
        return self.jump
    }
    
}
