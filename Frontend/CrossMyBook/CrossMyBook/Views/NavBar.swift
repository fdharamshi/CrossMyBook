//
//  NavBar.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        ZStack {
            VStack {
                Rectangle().fill(Color.black.opacity(0)).frame(height: 10)
                Rectangle().fill(Color.white).frame(height: 48)
            }
            HStack(alignment: .firstTextBaseline) {
                FAIcon(name: "home").padding(.leading, 18)
                Spacer()
                FAIcon(name: "users")
                Spacer()
                FAIcon(name: "plus-circle", size: 60)
                Spacer()
                FAIcon(name: "comments")
                Spacer()
                FAIcon(name: "user-circle").padding(.trailing, 18)
            }
        }.ignoresSafeArea()
    }
}



struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
