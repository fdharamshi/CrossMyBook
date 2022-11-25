//
//  FullReviewCardView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FullReviewCardView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            // user avatar
            WebImage(url: URL(string: BookParser.DefaultProfileURL)).resizable().scaledToFit().frame(width: 35, height: 35).cornerRadius(50).alignmentGuide(.firstTextBaseline) { context in
                context[.bottom] - 0.6 * context.height
            }
            // main body of the review card
            VStack(alignment: .leading) {
                // creator
                CustomText(s: "Alice", size: 16).bold()
                CustomText(s: "Sept 9, 2020 10:00", size: 14, color: Color.gray).bold()
                // content
                CustomText(s: "I found most of the poems very basic in structure and the imagery was limited to a small field of metaphors and anaphors. ", size: 16)
                // book preview
                BookPreviewView()
                HStack() {
                    Spacer()
                    FAIcon(name: "heart", size: 14, style: "regular")
                    FAIcon(name: "comment-dots", size: 14, style: "regular")
                    FAIcon(name: "share-square", size: 14, style: "regular")
                }
            }
        }.padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct FullReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        FullReviewCardView()
    }
}
