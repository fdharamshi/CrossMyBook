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
      let message = "Your car is currently at:\n(\(self.loc.latitude), \(self.loc.longitude))"
      return message
    }

    func generateMessage() -> String {
      let message = "\nWhen you want to map to this location, simply press the \"Where is my car?\" button."
      return message
    }
}
