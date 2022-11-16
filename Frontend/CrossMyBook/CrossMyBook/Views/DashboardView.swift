//
//  DashboardView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashboardView: View {
  
    @ObservedObject var profileController: ProfileController = ProfileController()
  
    @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
  
    var body: some View {
      VStack {
//        HStack {
//          Spacer()
//          Text("cog").font(.custom("FontAwesome5Free-Solid", size: CGFloat(28)))
//            .padding(.trailing, 20)
//            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
//        }
        HStack {
          WebImage(url: URL(string: profileController.profile?.profileUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(50)
                            .padding(.trailing, 20.0)
          VStack {
            Text(profileController.profile?.firstName ?? "")
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
//            Text("User ID: \(userID)")
//              .font(Font.custom("NotoSerif", size: 12))
//              .foregroundColor(Color("FontBlack"))
            NavigationLink(destination: LoginView()) {
              Text("Log out")
                            .font(Font.custom("NotoSerif", size: 12))
                            .foregroundColor(Color.blue)
            }
          }
        }.padding(.top, 20.0)
        HStack {
          Spacer()
          VStack {
            Text(String(profileController.profile?.reviewNumber ?? 0))
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
        .onAppear(perform: {
          profileController.fetchProfile(Int(userID) ?? 1)
      })
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
