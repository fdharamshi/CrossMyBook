//
//  ConversationView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/24/22.
//

import SwiftUI

struct ConversationView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    @State var message: String = ""
  
    var body: some View {
      VStack {
        ZStack (alignment: .leading) {
          Text("Caifei Hong")
            .font(.custom("NotoSerif", size: 20)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Button (action: {
            self.presentationMode.wrappedValue.dismiss() // TODO: back action
          }) {
            FAIcon(name: "chevron-left")
          }
        }.padding(10).background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
        
        ScrollView {
          VStack {
            
            HStack {
              Text("Can you tell me why do you want this book?")
                .font(.custom("NotoSerif", size: 13))
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(Color.lightBrown)
                .cornerRadius(25.0)
              Spacer()
            }.padding(.trailing, 20.0)
            
            HStack {
              Spacer()
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce quis orci malesuada, vulputate nunc a, gravida lorem. Donec est augue, suscipit in nisi aliquam, elementum auctor ex. Nullam a lorem eu massa pellentesque mollis. Quisque dapibus nisl tincidunt eros consequat pretium. Nunc feugiat lobortis ex, vitae efficitur metus elementum ac. Sed nec tristique augue. Nulla posuere tellus quis augue placerat, non vehicula mi lobortis. Nam ac vehicula eros. Vestibulum non augue non lectus vulputate mattis. Nunc id suscipit ante, sed euismod velit. Morbi scelerisque mauris blandit erat vulputate tristique. Vestibulum bibendum molestie feugiat. Maecenas in orci eu tortor rhoncus porttitor. Pellentesque tempus, nunc eget pharetra tristique, sem tortor semper libero, ut cursus metus eros pulvinar turpis.")
                .font(.custom("NotoSerif", size: 13))
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(Color.theme)
                .foregroundColor(Color.white)
                .cornerRadius(25.0)
            }.padding(.leading, 20.0)
            
            HStack {
              Spacer()
              Text("Send me the book.")
                .font(.custom("NotoSerif", size: 13))
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(Color.theme)
                .foregroundColor(Color.white)
                .cornerRadius(25.0)
            }.padding(.leading, 20.0)
          }.padding(20.0)
        }
        
        HStack {
          RoundedTextField(text: $message, placeholder: "Message", height: 38).autocorrectionDisabled(true).autocapitalization(.none)
            .padding(10.0)
          Button (action: {
            // TODO: Send Message Action
          }) {
            FAIcon(name: "paper-plane", size: 25)
          }
          .padding(.trailing, 20.0)
          
        }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      
      }.navigationBarHidden(true)
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
