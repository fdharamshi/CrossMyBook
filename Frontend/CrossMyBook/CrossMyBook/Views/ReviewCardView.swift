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
                CustomText(s: reviewData!.userName!, size: 14).bold()
                CustomText(s: formatDate(date: (reviewData?.date)!), size: 14, color: Color.gray)

                // content
                if ((reviewData?.content!.count)! > 100) {
                    Spacer()
                    CustomText(s: (reviewData?.content)!, size: 14)
                } else {
                    CustomText(s: " ", size: 14)
                    CustomText(s: (reviewData?.content)!, size: 14)
                    Spacer()
                }
                

            }.frame(minWidth: 200, maxWidth: 220, minHeight: 160, maxHeight: 160, alignment: .leading)
                .padding(12)
                .background(Color.white)
                .cornerRadius(5)
                
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
