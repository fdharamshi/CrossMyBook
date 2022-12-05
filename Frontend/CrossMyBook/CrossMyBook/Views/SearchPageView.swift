//
//  SearchPageView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/4/22.
//

import SwiftUI

struct SearchPageView: View {
  
  @State var searchString: String = ""
  var receivedSearchString: String
  @State var index: Int = 0
  
  func toggleIndex() {
    if(index == 0) {
      index = 1
    } else {
      index = 0
    }
  }
  
  init(searchString: String, receivedSearchString: String) {
    self.receivedSearchString = receivedSearchString
    self.searchString = receivedSearchString
  }
  
    var body: some View {
      VStack {
        HStack (alignment: .center) {
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("Search Book Title", text: $searchString)
                .font(Font.custom("NotoSerif", size: 15))
                .padding(.leading, 10.0)
                .autocorrectionDisabled(true)
                .onAppear(perform: {
                  searchString = receivedSearchString
                })
            )
            .frame(height: 38)
          Button(action: {
            // TODO: Search Action
          }) {
            FAIcon(name: "search", size: 20)
          }
        }
        HStack {
          
          if(index == 0)
          {
            Text("Pending")
              .frame(maxWidth: .infinity)
              .padding(10.0)
              .font(.custom("NotoSerif", size: 16))
              .background(Color("Theme"))
              .foregroundColor(Color.white)
              .cornerRadius(12.0)
          } else {
            Text("Pending")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(12.0)
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
              .cornerRadius(12.0)
          } else {
            Text("Accepted")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(12.0)
              .onTapGesture(perform: toggleIndex)
          }
        }.background(Color.white).cornerRadius(12.0).padding(.top, 10.0)
        
        ScrollView {
          VStack {
            
          }
        }
        
      }.padding(10.0).navigationBarHidden(true).background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
      SearchPageView(searchString: "", receivedSearchString: "Femin")
    }
}
