//
//  LandingView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct LandingView: View {
  
  let homeView = HomeView()
  let communityView = CommunityView()
  let messagingView = MessagingView()
  let dashboardView = DashboardView()
  
  @State var index: Int = 0
  
    var body: some View {
      NavigationView {
        VStack {
          ZStack (alignment: .trailingFirstTextBaseline) {
            Text("Cross My Book")
              .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            Button (action: {
//              self.presentationMode.wrappedValue.dismiss() // TODO: back action
            }) {
              FAIcon(name: "bell", size: 25)
            }
          }.padding(10) // TODO: Can someone add a shadow here?
          switch(index) {
          case 0: homeView
          case 1: communityView
          case 2: messagingView
          case 3: dashboardView
          default:
            homeView
          }
          NavBar(changeIndex: self.changeIndex(_:))
        }.edgesIgnoringSafeArea([.bottom])
      }.navigationBarHidden(true)
    }
  
  func changeIndex(_ newIndex: Int) {
    index = newIndex
  }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
