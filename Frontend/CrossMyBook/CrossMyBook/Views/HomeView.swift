//
//  HomeView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      VStack{
        Text("Home")
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.brown)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
