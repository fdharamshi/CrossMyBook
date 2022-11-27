//
//  CommunityParser.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import Foundation

class CommunityParser {
    // TODO: change to cloud server
    let urlString = "http://127.0.0.1:8000/getReviews"
    /**
     reviewType = 1 fetch all reviews
     reviewType = 2 fetch related reviews
     */
    func fetchReviews(userId: String = "2", reviewType: String = "1", completionHandler: @escaping((Reviews) -> ())) {
        let path = urlString + "?user_id=\(userId)" + "&review_type=\(reviewType)"
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
}
