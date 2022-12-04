//
//  ReviewCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct ReviewCardView: View {
    var reviewData: BDReview?
    
    var body: some View {
        if (reviewData != nil) {
            VStack(alignment: .leading) {
                HStack { // author + date
                    CustomText(s: reviewData!.userName!, size: 14).bold()
                    Spacer()
                    CustomText(s: formatDate(date: (reviewData?.date)!), size: 14).bold()
                }.padding(.leading, 8).padding(.trailing, 8)
                CustomText(s: (reviewData?.content)!, size: 14).padding(.leading, 8).padding(.trailing, 8)
            }.padding(10).frame(width: 200).background(Color.white).cornerRadius(5)
                
        }
        
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView()
    }
}
