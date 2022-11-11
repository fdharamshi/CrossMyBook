//
//  AlertRequestView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/11/22.
//

import SwiftUI

struct AlertRequestView: View {
  var body: some View {
    VStack (alignment: .leading){
      
      ScrollView {
        VStack (alignment: .leading) {
          
          HStack (alignment: .center) {
            
          }
          
        }.padding(.horizontal, 20.0)
      }
      
      // MARK: Action Buttons
      Button(action: {
        // TODO: Decline
      }) {
        Text("Decline").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255), lineWidth: 1)
          )
          .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
      }
      .buttonStyle(PlainButtonStyle())
      .padding(.horizontal, 20.0)
      Button(action: {
        // TODO: Accept
      }) {
        Text("Accept").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
          .foregroundColor(Color.white)
      }
      .buttonStyle(PlainButtonStyle())
      .padding(.horizontal, 20.0)
      
    }
  }
}

struct AlertRequestView_Previews: PreviewProvider {
  static var previews: some View {
    AlertRequestView()
  }
}
