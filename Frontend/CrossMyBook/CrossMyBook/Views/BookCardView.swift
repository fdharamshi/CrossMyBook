//
//  BookCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCardView: View {
    var bookData: Book
    var body: some View {
        HStack {
            WebImage(url: URL(string: bookData.coverURL)).resizable().scaledToFit().frame(height: 180).cornerRadius(5)
            VStack(alignment: .leading) {
                CustomText(s: bookData.title, size: 18).bold()
                CustomText(s: bookData.author, size: 14)
                Text(String(bookData.rating))// FIXME: add stars component
                CustomText(s: bookData.description, size: 12)
            }
        }.padding(18)
    }
}

struct BookCardView_Previews: PreviewProvider {
//    var bookDataMock: Book =
    static var previews: some View {
        BookCardView(bookData: Book(bookId: 1, coverURL: "https://covers.openlibrary.org/b/id/10447672-L.jpg", title: "Remarkably Bright Creatures", author: "Caifei Hong", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas placerat non elit ac vulputate. Nullam a libero lectus. Quisque eu fringilla lectus. ", rating: 4))
    }
}