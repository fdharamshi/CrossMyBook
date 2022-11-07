//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct RequestBookForm: View {
  
  @State var streetAddress: String = ""
  @State var zipCode: String = ""
  @State var note: String = ""
  
  var body: some View {
    
    VStack {
      HStack {
        Text("Cross My Book")
          .font(.custom("NotoSerif", size: 25)).bold()
      }
      ScrollView {
        
        HStack (alignment: .top) {
          Spacer()
          WebImage(url: URL(string: "https://covers.openlibrary.org/b/id/10447670-L.jpg"))
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150, alignment: .center)
            .border(Color.black, width: 1)
          
          VStack {
            VStack (alignment: .leading) {
              Text("Cracking the Coding Interview")
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("NotoSerif", size: 20))
                .bold()
              
              Text("James Clear")
                .font(.custom("NotoSerif", size: 15))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
              
              HStack (spacing: 1){
                ForEach (0..<5) {_ in
                  Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color.yellow)
                }
              }
              
            }
          }
          Spacer()
        }
        VStack {
          TextField("Name", text: .constant("Femin Dharamshi"))
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1.0)
            )
            .background(Color.white)
            
          
          TextField("Street Address", text: $streetAddress)
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.0)
            )
            .background(Color.white)
          
          TextField("Zip Code", text: $zipCode)
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.0)
            )
            .background(Color.white)
          
          TextField("Leave a note", text: $note, axis: .vertical)
            .lineLimit(10...)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .cornerRadius(5)
            .multilineTextAlignment(.leading)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.0)
            )
            .background(Color.white)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
      }
      Button(action: {
        print("Request Book")
      }) {
        Text("Request Book").font(.custom("NotoSerif", size: 15))
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
          .foregroundColor(Color.white)
      }
      .padding(.horizontal)
    }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    
  }
}

struct RequestBookForm_Previews: PreviewProvider {
  static var previews: some View {
    RequestBookForm()
  }
}
