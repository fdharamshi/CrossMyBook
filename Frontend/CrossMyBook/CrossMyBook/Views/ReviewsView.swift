//
//  ReviewsView.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/12/2.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewsView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var reviewActionController: ReviewActionController = ReviewActionController()
  
  @AppStorage("user_id") var userID: Int = -1
  
  @State var reviews: [ReviewSummary]
  let myReviewFlag: Bool
  
  func formatDate(date: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: isoFormatter.date(from: date) ?? Date())
  }

  var body: some View {
    NavigationView {
      VStack (alignment: .leading) {
        ZStack (alignment: .bottomLeading) {
          Text(myReviewFlag ? "My Reviews" : "Favorite Reviews")
            .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Button (action: {
            self.presentationMode.wrappedValue.dismiss() // TODO: back action
          }) {
            FAIcon(name: "chevron-left")
          }
        }.padding(10)
        if (reviews.count == 0) {
          Text("No review found")
            .font(Font.custom("NotoSerif", size: 15))
            .foregroundColor(Color(.gray))
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .center)
          Spacer()
        }
        else {
          List {
            ForEach(Array(reviews.enumerated()), id: \.1) { index, review in
              HStack {
                VStack {
                  WebImage(url: URL(string: review.bookCover))
                    .resizable()
                    .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                    .scaledToFit()
                    .frame(width: .infinity, height: 120, alignment: .center).cornerRadius(5)
                  Text(review.bookTitle)
                    .font(Font.custom("NotoSerif", size: 12)).bold()
                    .frame(width: 80).foregroundColor(Color.black).lineLimit(1)
                  Text(review.bookAuthor)
                    .font(Font.custom("NotoSerif", size: 10))
                    .frame(width: 80).foregroundColor(Color.black).lineLimit(1)
                }.padding(.trailing, 5)
                
                VStack(alignment: .leading) {
                  Text(formatDate(date: review.date))
                    .font(Font.custom("NotoSerif", size: 12))
                    .foregroundColor(Color(.gray))
                    .padding(.top, 5)
                  
                  Text(review.content)
                    .font(Font.custom("NotoSerif", size: 15)).lineLimit(5)
                  
                  Spacer()
                }
              }.listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions {
                  if (myReviewFlag == true) {
                    Button("Delete") {
                    }
                    .tint(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                  }
                  else {
                    Button("Unlike") {
                      reviewActionController.unlikeReview(userID: userID, reviewID: review.id)
                      self.reviews.remove(at: index)
                    }
                    .tint(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                  }
                }
            }
          }.scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
  }
}
