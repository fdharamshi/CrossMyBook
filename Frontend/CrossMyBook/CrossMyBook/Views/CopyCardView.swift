//
//  CopyCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct CopyCardView: View {
    var copy: BDCopy?
    var owner: String = "Caifei Hong"
    var status: String = "Unavailable"
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                CustomText(s: "Current Owner", size: 14, color: Color.theme).bold()
                CustomText(s: "Status", size: 14, color: Color.theme).bold()
            }.padding(10)
            VStack(alignment: .leading)  {
                CustomText(s: copy?.ownerName ?? owner, size: 14)
                CustomText(s: copy?.status == 0 ? "Available" : "Unavailable", size: 14)
            }
            Spacer()
            VStack {
                Button (action: {
                    print("Login")
                }) {
                    CustomText(s: "request", size: 12, color: Color.white).bold()
                }
                .padding()
                .background(Color.lightBrown)
                .cornerRadius(10)
            }.padding(14)
        }.background(Color.white)
    }
}

struct CopyCardView_Previews: PreviewProvider {
    static var previews: some View {
        CopyCardView()
    }
}
