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
        if (copy == nil) {
            CustomText(s: "We are waiting for more release...", size: 16)
        } else {
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
                    if (copy?.status == 0) {
                        // available
                        NavigationLink(destination: CopyDetailsView((copy?.copyId)!).navigationBarBackButtonHidden(true)) {
                            VStack {
                                CustomText(s: "Request", size: 12, color: Color.white).bold()
                            }
                            .padding()
                            .background(Color("Theme"))
                            .cornerRadius(10)
                        }
                    } else {
                        // unavailable
                        NavigationLink(destination: CopyDetailsView((copy?.copyId)!).navigationBarBackButtonHidden(true)) {
                            VStack {
                                CustomText(s: "detail", size: 12, color: Color.white).bold()
                            }
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                        }
                    }
                    
                    
                }.padding(14)
            }.background(Color.white)
        }
        
    }
}

struct CopyCardView_Previews: PreviewProvider {
    static var previews: some View {
        CopyCardView()
    }
}
