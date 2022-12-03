//
//  FullReviewCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullReviewCardView: View {
    var review: Review
    @State var like: Bool
    @ObservedObject var communityViewModel: CommunityViewModel
    @AppStorage("user_id") var userId: Int = -1
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
                            print("like")
                            like = !like
                            likeReview()
                        }) {
                            FAIcon(name: "heart", size: 14, style: "regular")
                        }
                    }else{
                        Button(action: {
                            print("unlike")
                            like = !like
                            unlikeReview()
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
                    
                    
                }.padding(.top, 5)
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
    
    func unlikeReview() {
        self.communityViewModel.unlikeReview(userId: userId, reviewId: review.reviewId) { (resp: (Bool, String)) in
            print(resp)
        }
    }
    
    func likeReview() {
        self.communityViewModel.likeReview(userId: userId, reviewId: review.reviewId) { (resp: (Bool, String)) in
            print(resp)
        }
    }
}

//struct FullReviewCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullReviewCardView()
//    }
//}
