//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct CopyDetailsView: View {
  
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
    var body: some View {
        
      ScrollView {
        
        HStack {
          Text("Cross My Book")
            .font(.custom("NotoSerif", size: 25)).bold()
        }
        
        ZStack (alignment: .bottomLeading) {
          Map(coordinateRegion: $mapRegion)
            .frame(height: 450)
          
          WebImage(url: URL(string: "https://covers.openlibrary.org/b/id/10447670-L.jpg"))
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150, alignment: .center)
            .offset(x: 30, y: 75)
        }
        
        VStack {
          VStack (alignment: .leading) {
            Text("Cracking the Coding Interview")
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
              .font(.custom("NotoSerif", size: 20))
              .bold()
              
            Text("James Clear")
              .font(.custom("NotoSerif", size: 15))
              .multilineTextAlignment(.leading)
              .fixedSize(horizontal: false, vertical: true)
            
            HStack (spacing: 1){
              ForEach (0..<5) {_ in
                Image(systemName: "star.fill")
                  .font(.system(size: 12))
                  .foregroundColor(Color.yellow)
              }
            }
            
            }.frame(maxWidth: UIScreen.main.bounds.size.width - 160, alignment: .leading)
            .offset(x: 150, y:0)
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        VStack {
          Text("Travel History")
            .font(.custom("NotoSerif", size: 18))
            .bold()
            .multilineTextAlignment(.leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
              ForEach(0..<10) {_ in
                  WebImage(url: URL(string: "https://randomuser.me/api/portraits/women/61.jpg"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70, alignment: .center)
                    .cornerRadius(35)
                
                  WebImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/3183/3183354.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                }
            }
        }.padding(.leading)
        
      }
      
    }
}

struct CopyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CopyDetailsView()
    }
}
