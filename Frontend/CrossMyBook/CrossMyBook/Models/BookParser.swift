//
//  Parser.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/6/22.
//

import Foundation

class BookParser {
    var bookId: Int = 1
    static var DefaultProfileURL: String = "https://xsgames.co/randomusers/assets/avatars/male/44.jpg"
    let urlString = "http://127.0.0.1:8000/getBookDetails?book_id=1"

    func fetchBookDetails(completionHandler: @escaping ((Book) -> ())) {
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) {
            (data, response, error) in
            guard let data = data else {
                print("Error! No Data!")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let bookData = try decoder.decode(Book.self, from: data)
//                print(bookData)
                completionHandler(bookData)
            } catch {
                print("Error! Can't decode data.")
                print(error)
            }
        }
        task.resume()
    }
}
