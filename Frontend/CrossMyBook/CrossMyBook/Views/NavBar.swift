//
//  NavBar.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct NavBar: View {
  
  var changeIndex: (Int) -> ()
  @State var isActive: Bool = false
  
  var body: some View {
        ZStack {
          HStack(alignment: .firstTextBaseline) {
            FAIcon(name: "home").padding(.leading, 18)
              .onTapGesture {
                changeIndex(0)
              }
            Spacer()
            FAIcon(name: "users")
              .onTapGesture {
                changeIndex(1)
              }
            Spacer()
            //      FAIcon(name: "plus-circle", size: 60)
            Text("circle").font(.custom("FontAwesome5Free-Solid", size: CGFloat(28))).foregroundColor(.white) // This is just a placeholder
            Spacer()
            FAIcon(name: "comments")
              .onTapGesture {
                changeIndex(2)
              }
            Spacer()
            FAIcon(name: "user-circle").onTapGesture {
              changeIndex(3)
            }.padding(.trailing, 18)
          }.padding(.bottom)
          NavigationLink(destination: ReleaseSelectionView()) {
            FAIcon(name: "plus-circle", size: 60)
              .background(Color.white)
              .cornerRadius(30)
          }.offset(x:0, y: -45)
        }
  }
}



struct NavBar_Previews: PreviewProvider {
  static var previews: some View {
    NavBar(changeIndex: {_ in })
  }
}
