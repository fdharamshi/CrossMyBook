//
//  BookDetailView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
    var body: some View {
        ScrollView {
        // MARK: top bar
            HStack {
                Button (action: {
                    print("Back") // TODO: back action
                }) {
                    FAIcon(name: "chevron-left")
                }
                Text("CrossMyBook").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }.padding(10)
        // MARK: book info
            BookCardView(bookData: Book(bookId: 1, coverURL: "https://covers.openlibrary.org/b/id/10447672-L.jpg", title: "Remarkably Bright Creatures", author: "Caifei Hong", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas placerat non elit ac vulputate. Nullam a libero lectus. Quisque eu fringilla lectus. ", rating: 4))
        // MARK: copy list
            VStack(alignment: .leading) {
                CustomText(s: "3 copies available now", size: 14).bold()
                HStack {
                    ForEach(1..<5) { index in
                        WebImage(url: URL(string: "https://xsgames.co/randomusers/assets/avatars/male/44.jpg")).resizable().scaledToFit().frame(width: 60, height: 60).cornerRadius(50)
                        Spacer()
                    }
                }

                CopyCardView()
            }.padding(.leading, 18).padding(.trailing, 18)
            
         // MARK reviews
            VStack(alignment: .leading)  {
                CustomText(s: "Reviews", size: 14).bold()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<5) { index in
                            ReviewCardView()
                        }
                    }
                }
            }.padding(18)
//            Spacer()
            NavBar()
        }
        .background(Color.backgroundGrey)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
