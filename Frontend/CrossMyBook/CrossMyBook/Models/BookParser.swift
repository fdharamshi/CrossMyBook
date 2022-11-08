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
    let urlString = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getBookDetails?book_id=1"
    
    func fetchBookDetails(completionHandler: @escaping ((Book) -> ())) {
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) {
            (data, response, error) in
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
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//                for review in bookData.reviews {
//                  let date = dateFormatter.date(from:review.date!)
//                    print(date)
//                }
                
                completionHandler(bookData)
            } catch {
                print("Error! Can't decode data.")
                print(error)
            }
        }
        task.resume()
    }
}
