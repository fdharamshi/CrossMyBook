//
//  HomeView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct HomeView: View {
  
  @ObservedObject var temporaryMainController: TemporaryMainController = TemporaryMainController()
  @ObservedObject var availableCopiesController: AvailableCopiesController = AvailableCopiesController()
  @ObservedObject var copyDetailsController: CopyDetailsController = CopyDetailsController()
  
  @AppStorage("user_id") var userID: Int = -1
  
  
  // Banner images, start displaying from index 0
  @State private var index = 0
  let banners: [String] = ["https://i.ibb.co/tDxD7Wk/banner1.png", "https://i.ibb.co/jbJh5VN/banner2.png", "https://i.ibb.co/FwJFrrB/banner3.jpg"]
  
  // For now, hardcode picked copy for the day
  let pickedCopy = 7
  
  init() {
    temporaryMainController.fetchDetails()
    availableCopiesController.fetchAvailableCopies()
    copyDetailsController.fetchCopyDetails(pickedCopy, userID)
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
          .padding(.top, 25)
        
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
                  
                }.padding(.leading, 15)
              }
            }
          }
        }
        
        Text("Travel route pick of the day")
          .font(Font.custom("NotoSerif", size: 15))
          .bold()
          .foregroundColor(Color("FontBlack"))
          .multilineTextAlignment(.leading)
          .padding(.leading, 15)
          .padding(.top, 25)
        
        Map(coordinateRegion: $copyDetailsController.mapRegion, annotationItems: copyDetailsController.observedCopy?.travelHistory ?? []) { tH in
          MapMarker(coordinate: CLLocationCoordinate2D(
            latitude: tH.lat,
            longitude: tH.lon
          ))
        }.frame(height: 200).cornerRadius(5)
          .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
        
        Text("All books")
          .font(Font.custom("NotoSerif", size: 15))
          .bold()
          .foregroundColor(Color("FontBlack"))
          .multilineTextAlignment(.leading)
          .padding(.leading, 15)
          .padding(.top, 25)
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top, spacing: 10) {
            ForEach(temporaryMainController.observedCopy?.allBooks ?? []) { listing in
              NavigationLink(destination: BookDetailView(bookId: String(listing.bookID ?? 1)).navigationBarHidden(true)) {
                VStack {
                  WebImage(url: URL(string: listing.coverURL))
                    .resizable()
                    .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                    .scaledToFit()
                    .frame(width: 100, height: 150, alignment: .center).cornerRadius(5)
                    .shadow(color: .gray, radius: 3, x: 0, y: 3)
                    .padding(.bottom, 3)
                  
                  Text(listing.title)
                    .font(Font.custom("NotoSerif", size: 12)).bold()
                    .frame(width: 100).foregroundColor(Color.black).lineLimit(1)
                  Text(listing.author)
                    .font(Font.custom("NotoSerif", size: 10))
                    .frame(width: 100).foregroundColor(Color.black).lineLimit(1)
                }.padding(.leading, 15)
              }
            }
          }
        }
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity).padding(.bottom, 30)
      .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      
    }
    }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
