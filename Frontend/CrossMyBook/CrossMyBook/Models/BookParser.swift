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
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookDetails?book_id="
    
    func fetchBookDetails(bookId: String = "1", completionHandler: @escaping ((Book) -> ())) {
        let task = URLSession.shared.dataTask(with: URL(string: urlString + bookId)!) {
            (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("Error! No Data!")
                    return
                }
                do {
                    let formatter = DateFormatter()
                    var decoder: JSONDecoder {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .custom { decoder in
                            let container = try decoder.singleValueContainer()
                            let dateString = try container.decode(String.self)
                            
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            if let date = formatter.date(from: dateString) {
                                return date
                            }
                            throw DecodingError.dataCorruptedError(in: container,
                                                                   debugDescription: "Cannot decode date string \(dateString)")
                        }
                        return decoder
                    }
                    
                    let bookData = try decoder.decode(Book.self, from: data)
                    completionHandler(bookData)
                } catch {
                    print("Error! Can't decode data.")
                    print(error)
                }
            }

        }
        task.resume()
    }
}
