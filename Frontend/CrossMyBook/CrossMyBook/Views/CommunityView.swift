//
//  CommunityView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct CommunityView: View {
    
    var body: some View {
        ScrollView{
            VStack{
                // MARK: buttons
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                    VStack {
                        CustomText(s: "Add a Review", size: 16, color: Color.white).frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.theme)
                    .cornerRadius(10)
                    
                }.padding(.bottom, 10).padding(.leading, 22).padding(.trailing, 22)
                HStack {
                    // TODO: button actions
                    Button(action: {
                        print("tab: all reviews")
                    }) {
                        CustomText(s: "All Reviews", size: 16, color: Color.theme).bold()
                    }.frame(minWidth: 170, minHeight: 43).background(Color.ultraLightBrown).cornerRadius(10)
                    Button(action: {
                        print("tab: related reviews")
                    }) {
                        CustomText(s: "Related To Me", size: 16, color: Color.fontBlack).bold()
                    }.frame(minWidth: 170, minHeight: 43).background(Color.white).cornerRadius(10)
                }.padding(.bottom, 10)
                
                // MARK: reviews
                ForEach(1..<4, id:\.self) {_ in
                    FullReviewCardView().padding(.leading, 25).padding(.trailing, 25).padding(.bottom, 12)
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Color.backgroundGrey)
            .onAppear(perform: loadCommunityData)
    }
    
    func loadCommunityData() {
        print("load community")
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
