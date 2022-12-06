//
//  CommunityView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct CommunityView: View {
    static var focusedBackgroundColor: Color = Color.ultraLightBrown
    static var focusedTextColor: Color = Color.theme
    static var unfocusedBackgroundColor: Color = Color.white
    static var unfocusedTextColor: Color = Color.fontBlack
    
    @ObservedObject var communityViewModel: CommunityViewModel = CommunityViewModel()
    @State var currentReviewType: String = "1" // 1-all, 2-related
    @State var allBtnBackgroundColor = focusedBackgroundColor
    @State var allBtnTextColor = focusedTextColor
    @State var relatedBtnBackgroundColor = unfocusedBackgroundColor
    @State var relatedBtnTextColor = unfocusedTextColor
    
    @AppStorage("user_id") var userId: Int = -1
    
    var body: some View {
        ScrollView{
            VStack{
                // MARK: buttons
                NavigationLink(destination: CreateReviewView()) {
                    VStack {
                        CustomText(s: "Add a Review", size: 16, color: Color.white).frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.theme)
                    .cornerRadius(10)
                    
                }.padding(.bottom, 10).padding(.leading, 22).padding(.trailing, 22)
                HStack {
                    Button(action: {
                        if (currentReviewType != "1") {
                            currentReviewType = "1"
                            loadCommunityData()
                            switchButtonStyle()
                        }
                    }) {
                        CustomText(s: "All Reviews", size: 16, color: allBtnTextColor).bold()
                    }.frame(minWidth: 170, minHeight: 43).background(allBtnBackgroundColor).cornerRadius(10)
                    Button(action: {
                        if (currentReviewType != "2") {
                            currentReviewType = "2"
                            loadCommunityData()
                            switchButtonStyle()
                        }
                    }) {
                        CustomText(s: "Related To Me", size: 16, color: relatedBtnTextColor).bold()
                    }.frame(minWidth: 170, minHeight: 43).background(relatedBtnBackgroundColor).cornerRadius(10)
                }.padding(.bottom, 10)
                
                // MARK: reviews
                if (self.communityViewModel.getReviews().count > 0) {
                    ForEach(self.communityViewModel.getReviews(), id: \.reviewId) { review in
                        FullReviewCardView(review: review, like: review.isLiked, communityViewModel: communityViewModel).padding(.leading, 25).padding(.trailing, 25).padding(.bottom, 12)
                    }
                } else {
                    CustomText(s: "No related reviews yet...", size: 16)
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Color.backgroundGrey)
            .onAppear(perform: loadCommunityData)
            .refreshable{
                loadCommunityData()
            }
    }
    
    func loadCommunityData() {
        let anonymous = { (fetchedReviews: Reviews) in
            self.communityViewModel.reviewsData = fetchedReviews
        }
        CommunityParser().fetchReviews(userId: String(userId), reviewType: currentReviewType, completionHandler: anonymous)
    }
    
    
    func switchButtonStyle() {
        if (currentReviewType == "1") {
            allBtnBackgroundColor = CommunityView.focusedBackgroundColor
            allBtnTextColor = CommunityView.focusedTextColor
            relatedBtnBackgroundColor = CommunityView.unfocusedBackgroundColor
            relatedBtnTextColor = CommunityView.unfocusedTextColor
        } else {
            allBtnBackgroundColor = CommunityView.unfocusedBackgroundColor
            allBtnTextColor = CommunityView.unfocusedTextColor
            relatedBtnBackgroundColor = CommunityView.focusedBackgroundColor
            relatedBtnTextColor = CommunityView.focusedTextColor
        }
    }
}

//struct CommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityView()
//    }
//}
