//
//  RatingBookView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import SwiftUI

struct RatingBookView: View {
    @State var rating: Int = 0
    var requireHalf: Bool = false
    static var offColor = Color.gray
    static var onColor = Color.lightBrown
    var updateRating: ((Int) -> Void)

    var onImage = Image(systemName: "star.fill")
    
    
    var body: some View {
        HStack {
            ForEach(1..<5 + 1, id: \.self) { number in
                Image(systemName: "star").resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28).foregroundColor(RatingBookView.offColor)
                    .onTapGesture {
                        print("rating: \(number)")
                        rating = number
                        updateRating(number)
                    }
            }
        }
    }
}

//struct RatingBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingBookView()
//    }
//}
