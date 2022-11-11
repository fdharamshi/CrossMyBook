//
//  AlertRequestView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/11/22.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct AlertRequestView: View {
  
  @State var request: Request
  
  var body: some View {
    VStack (alignment: .leading){
      
      ScrollView {
        VStack (alignment: .leading) {
          
          HStack (alignment: .top) {
            WebImage(url: URL(string: request.coverURL))
              .resizable()
              .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
              .scaledToFit()
              .frame(width: 100, height: 150, alignment: .center)
              .border(Color.black, width: 1)
              .background(Color.brown)
            
            VStack (alignment: .leading) {
              Text(request.title)
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("NotoSerif", size: 25))
                .bold()
              
              Text("Author Here")
                .font(.custom("NotoSerif", size: 15))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            }
          }
          
          Text("Requested By:")
            .font(.custom("NotoSerif", size: 15)).bold()
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 20.0)
          
          HStack (alignment: .center) {
            Spacer()
            VStack {
              WebImage(url: URL(string: request.userProfile))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
                .padding(.trailing, 20.0)
              Text(request.userName)
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("NotoSerif", size: 15))
                .bold()
            }
            Spacer()
          }
          
          HStack {
            Text("Address: ")
              .frame(width: .infinity)
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
              .font(.custom("NotoSerif", size: 15))
              .bold()
            Text("Pittsburgh, PA 15217") // TODO: Show this
              .frame(width: .infinity)
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
              .font(.custom("NotoSerif", size: 15))
          }.padding(.top, 10.0)
          
          Text("Note:")
            .frame(width: .infinity)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .font(.custom("NotoSerif", size: 15))
            .bold().padding(.top, 10.0)
          
          Text(request.note)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .font(.custom("NotoSerif", size: 15))
          
        }.padding(.horizontal, 20.0)
      }
      
      // MARK: Action Buttons
      Button(action: {
        // TODO: Decline
      }) {
        Text("Decline").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255), lineWidth: 1)
          )
          .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
      }
      .buttonStyle(PlainButtonStyle())
      .padding(.horizontal, 20.0)
      Button(action: {
        // TODO: Accept
      }) {
        Text("Accept").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
          .foregroundColor(Color.white)
      }
      .buttonStyle(PlainButtonStyle())
      .padding(.horizontal, 20.0)
      
    }
  }
}

struct AlertRequestView_Previews: PreviewProvider {
  static var previews: some View {
    AlertRequestView(request: Request(userID: 1, userProfile: "https://femindharamshi.com/static/media/favicon.df59357d43584154d3d1.png", userName: "Femin Dharamshi", copyID: 5, listingID: 5, date: "11th Nov, 2022", lat: 45.0, lon: -79.92, note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin facilisis lacus in vulputate molestie. Sed bibendum malesuada tortor vel pretium. Aliquam sollicitudin ullamcorper sodales. Mauris elit ante, auctor ut enim in, lobortis dapibus justo. Vivamus tristique sem molestie magna aliquam faucibus sodales a est. Proin elementum, sapien sit amet luctus vestibulum, tortor nisi lacinia sapien, ac semper ligula tellus eget tortor. Donec ac elit turpis. In at dolor eu est eleifend blandit. Morbi eget commodo nisi, non porta ipsum. Aenean lobortis diam a elit finibus ultrices. Nulla diam magna, dapibus vel mollis ac, eleifend at lacus. Nullam elementum dolor at auctor scelerisque. Integer posuere erat ac laoreet malesuada.", requestID: 8, coverURL: "https://covers.openlibrary.org/b/id/10290658-L.jpg", title: "Linchpin", listingLOC: ListingLOC(lat: 40.0, lon: -78)))
  }
}
