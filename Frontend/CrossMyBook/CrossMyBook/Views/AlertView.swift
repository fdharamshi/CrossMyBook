//
//  SwiftUIView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AlertView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var alertController: AlertController = AlertController()
  
  @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
  
  @State var index: Int = 0
  
  func toggleIndex() {
    if(index == 0) {
      index = 1
    } else {
      index = 0
    }
  }
  
  var body: some View {
    VStack {
      
      // MARK: TOP BAR
        ZStack (alignment: .leading) {
          Text("Requests")
            .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Button (action: {
              self.presentationMode.wrappedValue.dismiss() // TODO: back action
          }) {
            FAIcon(name: "chevron-left", size: 25)
          }.padding(.trailing, 20.0)
        }.padding(10).background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      
      // MARK: TAB BAR
      VStack {
        HStack {
          
          if(index == 0)
          {
            Text("Pending")
              .frame(maxWidth: .infinity)
              .padding(10.0)
              .font(.custom("NotoSerif", size: 16))
              .background(Color("Theme"))
              .foregroundColor(Color.white)
              .cornerRadius(25.0)
          } else {
            Text("Pending")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(25.0)
              .onTapGesture(perform: toggleIndex)
          }
          
          if(index == 1)
          {
            Text("Accepted")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .background(Color("Theme"))
              .foregroundColor(Color.white)
              .cornerRadius(25.0)
          } else {
            Text("Accepted")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(25.0)
              .onTapGesture(perform: toggleIndex)
          }
        }.background(Color.white).cornerRadius(25.0)
      }.padding(.horizontal, 20.0)
      
      ScrollView {
        VStack {
          ForEach(index == 0 ? alertController.observedCopy?.pendingRequests ?? [] : alertController.observedCopy?.acceptedRequests ?? []) { request in
            HStack (alignment: .top) {
              VStack {
                WebImage(url: URL(string: request.coverURL))
                  .resizable()
                  .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                  .scaledToFit()
                  .frame(width: 80, height: 120, alignment: .center)
                  .border(Color.black, width: 1)
                  .background(Color.brown)
                  .onTapGesture(perform: {
                    print("Jump to RequestView")
                  })
                Text(request.title).font(.custom("NotoSerif", size: 15)).bold().frame(width: 80).lineLimit(4)
              }
              VStack (alignment: .leading) {
                Text("Request ID: \(request.requestID)").padding(.bottom, 5.0)
                Text("Requester:").font(.custom("NotoSerif", size: 16)).bold()
                Text("\(request.userName)").padding(.bottom, 5.0)
                Text("Note:").font(.custom("NotoSerif", size: 16)).bold()
                Text("\(request.note)")
              }
              Spacer()
            }.padding(.horizontal, 20.0)
            Divider()
            }
          }
        }
      
      
    }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255)).onAppear(perform: {
      alertController.fetchAlertDetails(Int(userID) ?? 1)
    })
  }
}

struct AlertView_Previews: PreviewProvider {
  static var previews: some View {
    AlertView()
  }
}
