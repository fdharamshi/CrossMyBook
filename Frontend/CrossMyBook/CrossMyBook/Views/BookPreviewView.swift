//
//  BookPreviewView.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookPreviewView: View {
    var defaultCoverUrl = "https://m.media-amazon.com/images/I/41H9RiOb9gL.jpg"
    var body: some View {
        HStack (alignment: .top) {
            WebImage(url: URL(string: defaultCoverUrl)).resizable().scaledToFit().frame(width: 60, height: 87).cornerRadius(8)
            VStack(alignment: .leading) {
                CustomText(s: "Moloka'i", size: 14).bold().padding(.bottom, 7)
                CustomText(s: "by Alan Brennert", size: 14, color: Color.gray).bold()
            }.padding(.leading, 20)
            Spacer()
        }.padding(12).background(Color.backgroundGrey)
            .frame(maxWidth: .infinity)
    }
}

struct BookPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BookPreviewView()
    }
}
