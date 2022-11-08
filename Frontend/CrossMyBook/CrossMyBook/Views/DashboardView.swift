//
//  DashboardView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
      VStack{
        Text("User Dashboard")
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brown)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
