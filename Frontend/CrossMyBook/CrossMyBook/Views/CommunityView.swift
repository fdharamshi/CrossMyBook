//
//  CommunityView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct CommunityView: View {
  
  @State var finalCode: String = "Community Page"
  
    var body: some View {
      VStack{
        Text(finalCode)
        
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brown)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
