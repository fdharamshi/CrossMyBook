//
//  SettingsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/3/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  init() {
    UIScrollView.appearance().bounces = false
  }
  
  var body: some View {
    VStack {
      
      HStack {
        Spacer()
        Text("CrossMyBook")
          .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.white)
        Spacer()
      }
      .padding([.bottom, .top], 20)
      .background(Color.theme)
      
      ScrollView() {
        
        VStack (alignment: .center) {
          Text("Meet the Devs")
            .font(.custom("NotoSerif", size: 20))
            .bold()
            .frame(maxWidth: .infinity)
            .foregroundColor(.fontBlack)
            .padding(.top, 20.0)
          
          Divider().padding(10.0).padding(.bottom, 10.0)
          
          HStack (alignment: .top) {
            Spacer()
            VStack (alignment: .center) {
              WebImage(url: URL(string: "https://femindharamshi.com/static/media/favicon.df59357d43584154d3d1.png"))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(40)
              Text("Femin Dharamshi")
                .font(.custom("NotoSerif", size: 15)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }
            Spacer()
            VStack (alignment: .center) {
              WebImage(url: URL(string: "https://i.ibb.co/4SbyNqg/eutina.jpg"))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(40)
              Text("Yu-Ting Wei")
                .font(.custom("NotoSerif", size: 15)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }
            Spacer()
          }.padding(.bottom, 40.0)
          HStack (alignment: .top) {
            Spacer()
            VStack (alignment: .center) {
              WebImage(url: URL(string: "https://i.ibb.co/HtNSgfh/caifei.jpg"))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(40)
              Text("Caifei Hong")
                .font(.custom("NotoSerif", size: 15)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }
            Spacer()
            VStack (alignment: .center) {
              WebImage(url: URL(string: "https://media-exp1.licdn.com/dms/image/C4E03AQGxv_4-uiizFw/profile-displayphoto-shrink_200_200/0/1553036647470?e=1675296000&v=beta&t=0GwwOe_HJxSoRNJYlrBhGIvEWJTRX-W2vCIQmk0gnEI"))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(40)
              Text("Chenjun Zhou")
                .font(.custom("NotoSerif", size: 15)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }
            Spacer()
          }
          Divider().padding(10.0).padding(.bottom, 10.0)
          Text("About")
            .font(.custom("NotoSerif", size: 15)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Text("This app was created for the final project of the class 67-743: Mobile App Design and Development at Carnegie Mellon University.\n\nWe were able to complete the design and development of this app with the amazing guidance of Prof. Larry Heimann and our mentor TA, Sara Song. We also received immense amount of guidance from Matthew Kern, who works at Capital One as a Mobile App Developer and was our Mentor for this project. ")
            .font(.custom("NotoSerif", size: 15))
            .frame(maxWidth: .infinity)
            .foregroundColor(.fontBlack)
            .multilineTextAlignment(.center)
            .padding([.leading, .trailing, .bottom], 20.0)
        }
      }
      
      // MARK: Log Out Button
      NavigationLink(destination: LoginView()){
        Text("Log Out").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
          .foregroundColor(Color.white)
          .buttonStyle(PlainButtonStyle())
          .padding(.horizontal, 20.0)
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
