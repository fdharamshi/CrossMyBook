//
//  BookViewModel.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/6/22.
//

import Foundation

class BookViewModel: ObservableObject {
  // instance of parser
  
  // MARK: Fields
   @Published var bookData: Book!
  
  // MARK: Methods
    func availableCount() -> Int {
        if (bookData != nil) {
            return bookData!.copies.filter({ $0.status == 0}).count
        }
        return 0
    }
    
    func getCopies() -> [BDCopy] {
        if (bookData != nil) {
//            print(bookData!.copies)
            return bookData!.copies
        }
        return []
    }
    
    func getReviews() -> [BDReview] {
        if (bookData != nil) {
            print(bookData!.reviews)
            return bookData!.reviews
        }
        return []
    }
}

