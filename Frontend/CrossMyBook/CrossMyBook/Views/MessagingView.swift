//
//  MessagingView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagingView: View {
  
  @ObservedObject var conversationsController: ConversationController = ConversationController()
  
  var body: some View {
  
    VStack{
      if(conversationsController.observedCopy == nil || conversationsController.observedCopy?.conversations.count == 0) {
        Text("No messages yet").font(Font.custom("NotoSerif", size: 15))
      }
      if(conversationsController.observedCopy != nil) {
        ScrollView {
          VStack {
            ForEach(conversationsController.observedCopy?.conversations ?? []) { conversation in
              
              NavigationLink(destination: ConversationView(conversation.user.userID, conversation.user.name)) {
                HStack (alignment: .center) {
                  WebImage(url: URL(string: conversation.user.profileURL))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .cornerRadius(25)
                                    .padding(.trailing, 10.0)
                  Text(conversation.user.name).font(Font.custom("NotoSerif", size: 15))
                  Spacer()
                  VStack {
                    Text("11/11/2011") // TODO: Use the timestamp in model to display this
                    Text("11:11 PM")
                  }.font(Font.custom("NotoSerif", size: 13))
                }.padding(.horizontal, 20.0)
              }.foregroundColor(Color.fontBlack)
              Divider()
            }
          }
        }
      }
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      .onAppear(perform: {
        conversationsController.fetchConversations(1)
      })
  }
}

struct MessagingView_Previews: PreviewProvider {
  static var previews: some View {
    MessagingView()
  }
}
