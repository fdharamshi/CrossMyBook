//
//  BookDetailView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
    @ObservedObject var bookViewModel: BookViewModel = BookViewModel()
    @State var displayCopy: BDCopy? = nil
    
    
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
            BookCardView(bookData: self.bookViewModel.bookData)

            
        // MARK: copy list
            VStack(alignment: .leading) {
                CustomText(s: "\(self.bookViewModel.availableCount()) copies available now", size: 14).bold()
                HStack {
                    ForEach((self.bookViewModel.getCopies()), id: \.self.copyId) { copy in
                        Button(action: {
                            print("button pressed")
                            self.displayCopy = copy
                                }) {
                                    WebImage(url: URL(string: copy.ownerProfileUrl!.count > 0 ? copy.ownerProfileUrl! : BookParser.DefaultProfileURL)).resizable().scaledToFit().frame(width: 60, height: 60).cornerRadius(50)
                                }
                    }
                }
                CopyCardView(copy: self.displayCopy)
            }.padding(.leading, 18).padding(.trailing, 18)
            
         // MARK: reviews
            VStack(alignment: .leading)  {
                CustomText(s: "Reviews", size: 14).bold()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.bookViewModel.getReviews(), id: \.self.reviewId) { review in
                            ReviewCardView(reviewData: review)
                        }
                    }
                }
            }.padding(18)
            Spacer()
//            NavBar()
        }
        .background(Color.backgroundGrey)
        .onAppear(perform: loadBookData)
    }
    
    func loadBookData() {
        let anonymous = { (fetchedBook: Book) in
            self.bookViewModel.bookData = fetchedBook
            self.displayCopy = fetchedBook.copies[0]
        }
        BookParser().fetchBookDetails(completionHandler: anonymous)
        print(self.bookViewModel.bookData == nil)
    }
    
    
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
