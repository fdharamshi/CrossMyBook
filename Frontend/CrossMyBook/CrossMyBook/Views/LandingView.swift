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
          
          switch(index) {
          case 0: homeView
          case 1: communityView
          case 2: messagingView
          case 3: dashboardView
          default:
            homeView
          }
          NavBar(changeIndex: self.changeIndex(_:))
        }.edgesIgnoringSafeArea(.bottom)
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
