//
//  BookCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCardView: View {
    var bookData: Book?
    var body: some View {
        if (bookData != nil) {
            HStack {
                WebImage(url: URL(string: bookData!.coverURL)).resizable().scaledToFit().frame(height: 180).cornerRadius(5)
                .shadow(color: .gray, radius: 3, x: 0, y: 3)
                VStack(alignment: .leading) {
                    CustomText(s: bookData!.title, size: 18).bold().padding(.bottom, 0.5)
                  CustomText(s: bookData!.author, size: 14).padding(.bottom, 5)
                    RatingsView(rating: Int(floor(bookData!.rating)), requireHalf: (floor(bookData!.rating) < bookData!.rating))
                    CustomText(s: bookData!.description, size: 12)
                }.frame(width: UIScreen.main.bounds.width - 200)
                Spacer()
            }.padding(18)
        }
        
    }
}
//
//struct BookCardView_Previews: PreviewProvider {
////    var bookDataMock: Book =
//    static var previews: some View {
//        BookCardView(bookData: Book(bookId: 1, coverURL: "https://covers.openlibrary.org/b/id/10447672-L.jpg", title: "Remarkably Bright Creatures", author: "Caifei Hong", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas placerat non elit ac vulputate. Nullam a libero lectus. Quisque eu fringilla lectus. ", rating: 4))
//    }
//}
