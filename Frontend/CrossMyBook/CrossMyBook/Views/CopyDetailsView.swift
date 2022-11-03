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
        ZStack (alignment: .bottomLeading) {
          Map(coordinateRegion: $mapRegion)
            .frame(height: 250)
          
          WebImage(url: URL(string: "https://covers.openlibrary.org/b/id/10618651-L.jpg"))
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .offset(x: 30, y: 50)
        }
        VStack (alignment: .leading) {
          Text("Atomic Habits")
            .font(.custom("NotoSerif", size: 25))
            .offset(x: 150, y:0)
          }.frame(maxWidth: .infinity, alignment: .leading)
      }
      
    }
}

struct CopyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CopyDetailsView()
    }
}
