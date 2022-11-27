//
//  CommunityViewModel.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import Foundation

class CommunityViewModel: ObservableObject {
    @Published var reviewsData: Reviews!
    
    
    func getReviews() -> [Review] {
        if (reviewsData != nil) {
            return reviewsData!.reviews
        }
        return []
    }
}
