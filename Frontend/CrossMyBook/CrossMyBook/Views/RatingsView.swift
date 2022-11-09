//
//  RatingsView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/7/22.
//

import SwiftUI

struct RatingsView: View {
    var rating: Int
    var requireHalf: Bool
    var offColor = Color.gray
    var onColor = Color.lightBrown
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")
    var halfImage = Image(systemName: "star.leadinghalf.filled")
    
    
    var body: some View {
        HStack {
            ForEach(1..<5 + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor((number <= rating + 1 && requireHalf) ? onColor : offColor)
//                    .onTapGesture {
//                        rating = number
//                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number == rating + 1 && requireHalf == true {
            return halfImage
        }
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}
//
//struct RatingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingsView(rating: .constant(4))
//    }
//}
