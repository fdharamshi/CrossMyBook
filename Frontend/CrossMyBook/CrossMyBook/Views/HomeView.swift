//
//  HomeView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  
  @ObservedObject var temporaryMainController: TemporaryMainController = TemporaryMainController()
  @ObservedObject var availableCopiesController: AvailableCopiesController = AvailableCopiesController()
  
  @State private var index = 0
  let banners: [String] = ["https://i.ibb.co/tDxD7Wk/banner1.png", "https://i.ibb.co/jbJh5VN/banner2.png", "https://i.ibb.co/FwJFrrB/banner3.jpg"]
  
  init() {
    temporaryMainController.fetchDetails()
    availableCopiesController.fetchAvailableCopies()
  }
  
  var body: some View {
    ScrollView {
      VStack (alignment: .leading) {
        VStack {
          TabView(selection: $index) {
            ForEach((0..<3), id: \.self) { index in
              WebImage(url: URL(string: banners[index]))
                .resizable()
                .scaledToFill()
                .clipped()
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }.frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
        
        Text("Available copy nearby")
          .font(Font.custom("NotoSerif", size: 15))
          .bold()
          .foregroundColor(Color("FontBlack"))
          .multilineTextAlignment(.leading)
          .padding(.leading, 15)
          .padding(.top, 20.0)
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top, spacing: 10) {
            ForEach(availableCopiesController.availableCopiesModel?.availableCopies ?? []) { copy in
              NavigationLink(destination: CopyDetailsView(copy.copyId).navigationBarHidden(true)) {
                VStack {
                  WebImage(url: URL(string: copy.coverUrl))
                    .resizable()
                    .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                    .scaledToFit()
                    .frame(width: 100, height: 150, alignment: .center).cornerRadius(5)
                    .shadow(color: .gray, radius: 3, x: 0, y: 3)
                    .padding(.bottom, 3)
                  
                  Text(copy.title)
                    .font(Font.custom("NotoSerif", size: 12)).bold()
                    .frame(width: 100).foregroundColor(Color.black).lineLimit(1)
                  Text(copy.author)
                    .font(Font.custom("NotoSerif", size: 10))
                    .frame(width: 100).foregroundColor(Color.black).lineLimit(1)
                  
                }.padding(.leading, 20)
              }
            }
          }
        }
        
        Text("All books")
          .font(Font.custom("NotoSerif", size: 15))
          .bold()
          .foregroundColor(Color("FontBlack"))
          .multilineTextAlignment(.leading)
          .padding(.leading, 15)
          .padding(.top, 20.0)
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top, spacing: 10) {
            ForEach(temporaryMainController.observedCopy?.allBooks ?? []) { listing in
                NavigationLink(destination: BookDetailView(bookId: String(listing.bookID ?? 1)).navigationBarHidden(true)) {
                    VStack {
                      WebImage(url: URL(string: listing.coverURL))
                        .resizable()
                        .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                        .scaledToFit()
                        .frame(width: 100, height: 150, alignment: .center)
                        .border(Color.black, width: 1)
                        .background(Color.brown).padding(.leading, 20)
                      Text(listing.title).frame(width:100).padding(.leading, 20).foregroundColor(Color.black).lineLimit(4)
                    }
                }
            }
            
          }
        }
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      
    }
    }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
