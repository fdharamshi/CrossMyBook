//
//  BookPreviewView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/24/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct PreviewBook {
    let bookId: Int
    let bookCover: String
    let bookTitle: String
    let bookAuthor: String
    
    init(bookId: Int, bookCover: String, bookTitle: String, bookAuthor: String) {
        self.bookId = bookId
        self.bookCover = bookCover
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
    }
}
struct BookPreviewView: View {
    var defaultCoverUrl = "https://m.media-amazon.com/images/I/41H9RiOb9gL.jpg"
    var review: PreviewBook
    var body: some View {
        NavigationLink(destination: BookDetailView(bookId: String(review.bookId)).navigationBarBackButtonHidden(true)) {
            HStack (alignment: .top) {
                WebImage(url: URL(string: review.bookCover)).resizable().scaledToFit().frame(width: 60, height: 87).cornerRadius(5)
                VStack(alignment: .leading) {
                    CustomText(s: review.bookTitle, size: 14).bold().padding(.bottom, 3)
                    CustomText(s: "by \(review.bookAuthor)", size: 14, color: Color.gray).bold()
                }.padding(.leading, 5)
                Spacer()
            }.padding(12).background(Color.backgroundGrey)
            .frame(maxWidth: .infinity).cornerRadius(5)
        }
    }
}

//struct BookPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookPreviewView()
//    }
//}
