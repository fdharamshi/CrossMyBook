//
//  FullReviewCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullReviewCardView: View {
    @State var like = false
    var review: Review
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            // user avatar
            WebImage(url: URL(string: review.userAvatar )).resizable().scaledToFit().frame(width: 35, height: 35).cornerRadius(50).alignmentGuide(.firstTextBaseline) { context in
                context[.bottom] - 0.6 * context.height
            }
            // main body of the review card
            VStack(alignment: .leading) {
                // creator
                CustomText(s: review.userName, size: 16).bold()
                CustomText(s: formatDate(date: review.date), size: 14, color: Color.gray).bold()
                // content
                CustomText(s: review.content, size: 16)
                // book preview
                BookPreviewView(review: PreviewBook(bookId: review.bookId, bookCover: review.bookCover, bookTitle: review.bookTitle, bookAuthor: review.bookAuthor))
                HStack() {
                    Spacer()
                    if (!like){
                        Button(action: {
                            print("clicked")
                            like = !like
                            
                        }) {
                            FAIcon(name: "heart", size: 14, style: "regular")
                            
                        }
                    }else{
                        Button(action: {
                            print("clicked")
                            like = !like
                        }) {
                            FAIcon(name: "heart", size: 14, style: "solid")
                        }
                    }
                    
                    Button(action: {}) {
                        FAIcon(name: "comment-dots", size: 14, style: "regular")
                    }
                    Button(action: {}) {
                        FAIcon(name: "share-square", size: 14, style: "regular")
                    }
                    
                    
                }
            }.padding(.leading, 4)
        }.padding()
        .background(Color.white)
        .cornerRadius(10)
    }
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

//struct FullReviewCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullReviewCardView()
//    }
//}
