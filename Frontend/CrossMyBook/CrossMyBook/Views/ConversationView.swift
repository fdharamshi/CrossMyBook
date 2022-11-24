//
//  ConversationView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import SwiftUI

// TODO: Auto Scroll to the latest message
// TODO: Show the other person's display picture?

struct ConversationView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var message: String = ""
  
  @ObservedObject var messagesController: MessagingController = MessagingController()
  
    let user2: Int
    let userName: String
    @AppStorage("user_id") var userID: String = "-1"
  
  let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
  
  init(_ user_2: Int, _ name: String) {
      user2 = user_2
      userName = name
    }
  
    var body: some View {
      VStack {
        ZStack (alignment: .leading) {
          Text(userName)
            .font(.custom("NotoSerif", size: 20)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Button (action: {
            timer.upstream.connect().cancel()
            self.presentationMode.wrappedValue.dismiss() // TODO: back action
          }) {
            FAIcon(name: "chevron-left")
          }
        }.padding(10).background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
        
        ScrollView {
          VStack {
            
            ForEach(messagesController.observedCopy?.messages ?? []) { message in
              
              if( message.sender == (Int(userID) ?? 1) ) {
                HStack {
                  Spacer()
                  Text(message.message)
                    .font(.custom("NotoSerif", size: 13))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.theme)
                    .foregroundColor(Color.white)
                    .cornerRadius(25.0)
                }.padding(.leading, 20.0)
              } else {
                HStack {
                  Text(message.message)
                    .font(.custom("NotoSerif", size: 13))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(Color.lightBrown)
                    .cornerRadius(25.0)
                  Spacer()
                }.padding(.trailing, 20.0)
              }
              
            }
          }.padding(20.0)
        }.onReceive(timer) {time in
          messagesController.fetchMessages(Int(userID) ?? 1, user2)
          print("Fetching")
        }
        
        HStack {
          RoundedTextField(text: $message, placeholder: "Message", height: 38).autocorrectionDisabled(true).autocapitalization(.none)
            .padding(10.0)
          Button (action: {
            messagesController.sendMessage(sender: Int(userID) ?? 1, receiver: user2, message: message)
            message = ""
          }) {
            FAIcon(name: "paper-plane", size: 25)
          }
          .padding(.trailing, 20.0)
          
        }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      
      }.navigationBarHidden(true).onAppear(perform: {
        messagesController.fetchMessages(Int(userID) ?? 1, user2)
      })
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(2, "Femin Dharamshi")
    }
}
