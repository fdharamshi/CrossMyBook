//
//  PopupView.swift
//  CrossMyBook
//
//  Created by Caifei H on 12/4/22.
//

import SwiftUI

struct PopupView: View {
    var review: BDReview?
    
    
    var body: some View {
      ScrollView {
        VStack(alignment: .leading) {
          CustomText(s: review?.userName ?? "", size: 18, color: Color.fontBlack).bold().padding(.bottom, 0.5)
          CustomText(s: formatDate(date: review?.date ?? Date()), size: 16, color: Color.gray).bold().padding(.bottom, 0.5)
          CustomText(s: review?.content ?? "", size: 16)
        }
        .padding(18)
        .background(Rectangle()
          .fill(Color.white)
        )
        .cornerRadius(10)
      }
        .frame(minWidth: 280, maxWidth: 280, minHeight: 280).padding(18)
    }
    
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
