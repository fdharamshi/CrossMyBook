//
//  BookDetailView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
  
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var bookViewModel: BookViewModel = BookViewModel()
    @State var displayCopy: BDCopy? = nil
    @State var showingPopup = false
    @State var blurRadius: CGFloat = 0
    @State var popupReview: BDReview?
    
    var bookId: String = "3"
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: top bar
                HStack {
                    Button (action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        FAIcon(name: "chevron-left")
                    }
                    Text("CrossMyBook").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                }.padding(10)
              
                ScrollView {
                    // MARK: book info
                    BookCardView(bookData: self.bookViewModel.bookData)
                  
                    // MARK: copy list
                    VStack(alignment: .leading) {
                        CustomText(s: "\(self.bookViewModel.availableCount()) copies available now", size: 16).bold()
                        
                        HStack {
                            ForEach((self.bookViewModel.getCopies()), id: \.self.copyId) { copy in
                                Button(action: {
                                    self.displayCopy = copy
                                }) {
                                    WebImage(url: URL(string: copy.ownerProfileUrl!.count > 0 ? copy.ownerProfileUrl! : BookParser.DefaultProfileURL)).resizable().scaledToFit().frame(width: 60, height: 60).cornerRadius(50)
                                }
                            }
                        }.padding(.bottom, 5)
                      CopyCardView(copy: self.displayCopy).cornerRadius(5)
                    }.padding(.leading, 18).padding(.trailing, 18)
                    
                    // MARK: reviews
                    VStack(alignment: .leading)  {
                        CustomText(s: "Reviews", size: 16).bold()
                        ScrollView(.horizontal) {
                            if (self.bookViewModel.getReviews().count > 0) {
                                HStack(alignment: .top) {
                                    ForEach(self.bookViewModel.getReviews(), id: \.self.reviewId) { review in
                                        Button(action: {
                                            showPopup()
                                            popupReview = review
                                        }) {
                                            ReviewCardView(reviewData: review)
                                        }.disabled(showingPopup)
                                    }
                                }
                            } else {
                                CustomText(s: "We are waiting for more reviews...", size: 16)
                            }
                            
                        }
                    }.padding(18)
                    Spacer()
                }
                }
            .background(Color.backgroundGrey)
            .onAppear(perform: loadBookData)
            .onTapGesture {
                self.dimissPopup()
            }.blur(radius: blurRadius)
            
            
            if (showingPopup) {
                PopupView(review: popupReview)
            }
        }
        
    }
    
    func showPopup() {
        showingPopup = true
        blurRadius = 5
    }
    
    func dimissPopup() {
        showingPopup = false
        blurRadius = 0
    }
    
    func loadBookData() {
        print("book id: ", bookId)
        let anonymous = { (fetchedBook: Book) in
            self.bookViewModel.bookData = fetchedBook
//            print(self.bookViewModel.bookData)
            if (fetchedBook.copies.count > 0) {
                self.displayCopy = fetchedBook.copies[0]
            }
        }
        BookParser().fetchBookDetails(bookId: bookId, completionHandler: anonymous)
    }
    
    
}

//struct BookDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookDetailView()
//    }
//}
