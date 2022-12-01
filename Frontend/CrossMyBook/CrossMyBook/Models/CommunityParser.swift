//
//  CommunityParser.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import Foundation

class CommunityParser {
    // TODO: change to cloud server
    let urlPrefix = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000"
    
    /**
     reviewType = 1 fetch all reviews
     reviewType = 2 fetch related reviews
     */
    func fetchReviews(userId: String = "1", reviewType: String = "1", completionHandler: @escaping((Reviews) -> ())) {
        let path = urlPrefix + "/getReviews?user_id=\(userId)" + "&review_type=\(reviewType)"
        let task = URLSession.shared.dataTask(with: URL(string: path)!) {
            (data, response, error) in
            guard let data = data else {
                print("Error! No Data!")
                return
            }
            do {
                let formatter = DateFormatter()
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom{ decoder in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                    throw DecodingError.dataCorruptedError(in: container,
                                                           debugDescription: "Cannot decode date string \(dateString)")
                }
                let reviewsData = try decoder.decode(Reviews.self, from: data)
                completionHandler(reviewsData)
            } catch {
                print("Error! Can't decode data")
                print(error)
            }
        }
        task.resume()
    }
    
    
    func fetchUserBooks(userId: String = "1", completionHandler: @escaping(([crossedBook]) -> ())) {
        let path = urlPrefix + "/getBookByUserId?user_id=\(userId)"
        let task = URLSession.shared.dataTask(with: URL(string: path)!) {
            (data, response, error) in
            guard let data = data else {
                print("Error! No Data!")
                return
            }
            do {
                let decoder = JSONDecoder()
                let booksResp = try decoder.decode(UserBooks.self, from: data)
                let booksData = booksResp.currentBooks + booksResp.historyBooks
                completionHandler(booksData)
            } catch {
                print("Error! Can't decode data")
                print(error)
            }
        }
        task.resume()
    }
}
