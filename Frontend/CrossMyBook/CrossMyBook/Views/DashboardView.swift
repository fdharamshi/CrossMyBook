//
//  DashboardView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashboardView: View {
    var body: some View {
      VStack {
        HStack {
          Spacer()
          Text("cog").font(.custom("FontAwesome5Free-Solid", size: CGFloat(28)))
            .padding(.trailing, 20)
            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
        }
        HStack {
          WebImage(url: URL(string: "https://67443.cmuis.net/assets/profh_teaching-d359630aeb42e1df48858ad439592fff6049740ed8c252a949c41e07fae4709e.png"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(50)
                            .padding(.trailing, 20.0)
          VStack {
            Text("Larry")
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
            Text("User ID: 1")
              .font(Font.custom("NotoSerif", size: 12))
              .foregroundColor(Color("FontBlack"))
          }
        }
        HStack {
          Spacer()
          VStack {
            Text("5")
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
            Text("Reviews")
              .font(Font.custom("NotoSerif", size: 15))
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          }
          Spacer()
          VStack {
            Text("45")
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
            Text("Favourites")
              .font(Font.custom("NotoSerif", size: 15))
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          }
          Spacer()
        }
        Spacer()
        Text("User Dashboard")
        Text("This page is non-functional")
        Spacer()
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
