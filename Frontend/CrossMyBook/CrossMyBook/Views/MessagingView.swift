//
//  MessagingView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI

struct MessagingView: View {
    var body: some View {
        
      VStack{
        Text("Messages")
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brown)
    }
}

struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
