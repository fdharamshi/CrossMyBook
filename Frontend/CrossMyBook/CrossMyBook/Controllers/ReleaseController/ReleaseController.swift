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
    let loc: Location = Location()
    
    func fetchBookDetails(isbn: String) {
        fetchData(isbn, completion: { bookModel in
            self.book = bookModel
        })
        if book != nil {
            print(book!.title)
        }
        
    }
    
    private func fetchData(_ isbn: String, completion: @escaping (ISBNBook) -> ()) {
        let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookFromISBN?isbn=\(isbn)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                print("Error: No data to decode")
                return
            }
            
            // Decode the JSON here
            guard let book = try? JSONDecoder().decode(ISBNBook.self, from: data) else {
                print("Error: Couldn't decode data into a result")
                return
            }
            print(book.title)
            completion(book)
        }
        task.resume()
    }
    
    func releaseNewBook(){
        print(release.note)
    }
    
    func inputZipCode(zip:String){
        release.zipCode = Int(zip) ?? 0
    }
    
    func generateTitle() -> String {
        let message = "Your location is at:\n(\(self.loc.latitude), \(self.loc.longitude))"
        return message
    }
    
    func createRelease() {
        // Prepare URL
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/releaseNew")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        // MARK: UserID hard code to 1
        //        let postString = "userId=1&book_id=\(book?.bookID ?? 0)&lat=\(loc.latitude)&lon=\(loc.longitude)&book_condition=\(release.condition)&charges=\(release.shipping)&max_distance=\(release.distance)&note=\(release.note)";
        let postString = "user_id=1&book_id=3&lat=0&lon=0&book_condition=Good&charges=Incurrent by the Requester&max_distance=Same City&note=someNotes";
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data)
            print(response)
            print(error)
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
    
}
