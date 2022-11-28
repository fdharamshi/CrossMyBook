//
//  CreateReviewView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateReviewView: View {
    var defaultCoverUrl = "https://m.media-amazon.com/images/I/41H9RiOb9gL.jpg"
    @State private var searchText = ""
    @State private var reviewInput = ""
    
    var body: some View {
        ScrollView {
            VStack {
                CustomText(s: "Choose a book you received", size: 20).frame(maxWidth: .infinity)
                TextField("Search a book", text: $searchText, onCommit: {
                    print("search text: \($searchText)")
                }).multilineTextAlignment(.center)
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .padding(.leading, 28)
                    .padding(.trailing, 28)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1..<6, id:\.self) { _ in
                            WebImage(url: URL(string: defaultCoverUrl)).resizable().scaledToFit().frame(width: 64, height: 97).cornerRadius(5).padding(9)
                        }
                    }.padding(28)
                }
                
                CustomText(s: "My Rating", size: 18).bold()
                RatingBookView()
                
                TextField("Write your thoughts here...", text: $reviewInput, axis: .vertical)
                    .lineLimit(10...)
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 15, trailing: 20))
                    .multilineTextAlignment(.leading)
                    .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                    .padding(36)
                
                Button(action: {
                    print("submit review")
                }) {
                    CustomText(s: "Submit", size: 20, color: Color.white).bold()
                }.frame(minWidth: 284, minHeight: 60).background(Color.theme).cornerRadius(10).padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
        }.background(Color.backgroundGrey)
        
    }
}


struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReviewView()
    }
}
