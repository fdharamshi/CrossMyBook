//
//  ShareView.swift
//  CrossMyBook
//
//  Created by Caifei H on 12/3/22.
//

import SwiftUI

struct ShareView: View {
    var review: Review
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                CustomText(s: review.bookTitle, color: Color.fontBlack).bold()
                CustomText(s: "Book Author: " + review.bookAuthor, size: 16)
                CustomText(s: "“", size: 40, color: Color.theme)
                CustomText(s: "  " + review.content, size: 18)
                CustomText(s: "                               ”", size: 40, color: Color.theme)
                HStack {
                    CustomText(s: review.userName, size: 16).bold()
                    CustomText(s: "@CrossMyBook", size: 16, color: Color.theme).bold()
                }
                
                CustomText(s: formatDate(date: Date()), size: 16, color: Color.gray).bold()
            }
            .padding(18)
                .background(Rectangle()
                    .fill(Color.backgroundGrey)
                    .shadow( // shadow not work
                        color: Color.gray.opacity(0.7),
                        radius: 8,
                        x: 0,
                        y: 0
                     ))
                .cornerRadius(10)
                .frame(maxWidth: 380, minHeight: 480)
            VStack {
                Image(systemName: "books.vertical").resizable()
                    .scaledToFit().frame(width: 140, height: 140).foregroundColor(Color.lightBrown).opacity(0.3)
            }.offset(x: 80, y: -170)
            
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

//struct ShareView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        ShareView()
//    }
//}
