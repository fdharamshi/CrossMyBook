//
//  RoundedTextField.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/7.
//

import SwiftUI

struct RoundedTextField: View {
    @Binding var text: String
    var placeholder: String
    var height: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
          .fill(.white)
          .overlay(
            TextField(placeholder, text: $text)
              .padding(.leading)
              .font(Font.custom("NotoSerif", size: 14))
          )
          .frame(height: height)
    }
}
