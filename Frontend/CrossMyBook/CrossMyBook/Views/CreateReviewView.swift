//
//  CreateReviewView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateReviewView: View {
    @ObservedObject var communityViewModel: CommunityViewModel = CommunityViewModel()
    var defaultCoverUrl = "https://m.media-amazon.com/images/I/41H9RiOb9gL.jpg"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var presentAlert = false
    @State private var alertMsg = ""
    @State private var searchText = ""
    @State private var reviewInput = ""
    @State private var rating: Int = 0
    @State var selectedBook: crossedBook? = nil
    @State var submitSuccess: Bool = false
    @AppStorage("user_id") var userId: Int = -1
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: CommunityView().navigationBarBackButtonHidden(true).navigationBarHidden(true)
            , isActive: $submitSuccess) {
                EmptyView()
            }
            VStack {
                CustomText(s: "Choose a book you received", size: 20).frame(maxWidth: .infinity)
                
                ScrollView(.horizontal) {
                    HStack {
                        if(self.communityViewModel.getUserBooks().count > 0) {
                            ForEach(self.communityViewModel.getUserBooks(), id: \.bookId) { book in
                                Button(action: {
                                    self.selectedBook = book
                                }) {
                                    WebImage(url: URL(string: book.bookCover)).resizable().scaledToFit().frame(width: 64, height: 97).cornerRadius(5).padding(9)
                                }
                            }
                        }
                    }.padding(28)
                }
                if (self.selectedBook != nil) {
                    BookPreviewView(review: PreviewBook(bookId: selectedBook!.bookId, bookCover: selectedBook!.bookCover, bookTitle: selectedBook!.bookTitle, bookAuthor: selectedBook!.bookAuthor)).padding(32)
                }
                CustomText(s: "My Rating", size: 18).bold()
                RatingBookView(updateRating: self.updateRating)
                
                TextField("Write your thoughts here...", text: $reviewInput, axis: .vertical)
                    .lineLimit(10...)
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 15, trailing: 20))
                    .multilineTextAlignment(.leading)
                    .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                    .padding(36)
                
                Button(action: {
                    submitReview()
                }) {
                    CustomText(s: "Submit", size: 20, color: Color.white).bold()
                }.frame(minWidth: 284, minHeight: 60).background(Color.theme).cornerRadius(10).padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
        }
        .background(Color.backgroundGrey)
        .onAppear(perform: getUserBooks)
        .alert(isPresented: $presentAlert) {
            Alert(
                title: Text(alertMsg),
                dismissButton: .default(Text("Got it")) {
                    if (alertMsg == "You successfully created a review!") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
    
    func updateRating(number: Int) -> Void {
        self.rating = number
    }
    
    func getUserBooks() {
        let anonymous = { (fetchedBooks: [crossedBook]) in
            self.communityViewModel.userBooks = fetchedBooks
        }
        CommunityParser().fetchUserBooks(userId: String(userId), completionHandler: anonymous)
    }
    
    func submitReview() {
        self.communityViewModel.createReview(userId: userId, bookId: selectedBook?.bookId ?? -1, content: $reviewInput.wrappedValue, stars: rating) { (resp: (Bool, String)) in
            presentAlert = true
            if (resp.0 == true) {
                alertMsg = "You successfully created a review!"
            } else {
                alertMsg = resp.1 // error info
            }
        }
    }
}


//struct CreateReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateReviewView()
//    }
//}
