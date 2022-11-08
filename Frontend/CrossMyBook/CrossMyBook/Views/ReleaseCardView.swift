//
//  ReleaseCardView.swift
//  CrossMyBook
//
//  Created by Azathoth on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReleaseCardView: View {
    var book: ISBNBook?
    var body: some View {
        if (book != nil) {
            HStack {
                WebImage(url: URL(string: book!.coverURL)).resizable().scaledToFit().frame(height: 180).cornerRadius(5)
                VStack(alignment: .leading) {
                    CustomText(s: book!.title, size: 18).bold()
                    CustomText(s: book!.author, size: 14)
                    RatingsView(rating: Int(floor(book!.rating)), requireHalf: (floor(book!.rating) < book!.rating))
                }
            }.padding(18)
        }
        
    }
}

