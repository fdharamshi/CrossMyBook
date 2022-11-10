//
//  ReleaseController.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import Foundation

class ReleaseEditController: ObservableObject {
    let copyId: Int
    
    
    init(copyId: Int) {
        self.copyId = copyId
        fetchCurrentListing(copyId: copyId)
    }
    
    func fetchCurrentListing(copyId: Int){
        
    }
    
    func updateListing(){
        
    }
    
}
