//
//  ReviewCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct ReviewCardView: View {
    var body: some View {
        VStack {
            HStack {
                // author + date
                CustomText(s: "Alice", size: 14).bold()
                Spacer()
                CustomText(s: "Sept 9, 2022", size: 14).bold()
            }.padding(.leading, 8).padding(.trailing, 8)
            CustomText(s: "Over the years, this book has been recommended to me on more than one occasion, but I just never felt an urgent pull... (more) ", size: 14).padding(.leading, 8).padding(.trailing, 8)
        }.frame(width: 200)
            .background(Color.white)
            .padding(4)
    }
}

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView()
    }
}
