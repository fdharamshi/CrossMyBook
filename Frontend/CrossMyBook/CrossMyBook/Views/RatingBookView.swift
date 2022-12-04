//
//  RatingBookView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import SwiftUI

struct RatingBookView: View {
    @State var rating: Int = 0
    @State var starColors = [Color](repeating: Color.gray, count: 5)
    @State var starNames = [String](repeating: "star", count: 5)

    var updateRating: ((Int) -> Void)
    
    
    var body: some View {
        HStack {
            ForEach(1..<5 + 1, id: \.self) { number in
                Image(systemName: starNames[number - 1]).resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28).foregroundColor(starColors[number - 1])
                    .onTapGesture {
                        updateStars(number)
                        rating = number
                        updateRating(number)
                    }
            }
        }
    }
    
    func updateStars(_ number: Int) {
        for index in 0...(number - 1) {
            starNames[index] = "star.fill"
            starColors[index] = Color.lightBrown
        }
        if (number < 5) {
            for index in number...4 {
                starNames[index] = "star"
                starColors[index] = Color.gray
            }
        }
    }
}

//struct RatingBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingBookView()
//    }
//}
