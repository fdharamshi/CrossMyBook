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
    var passwordStyle: Bool = false

    var body: some View {
        if (passwordStyle) {
            RoundedRectangle(cornerRadius: 10)
              .fill(.white)
              .overlay(
                SecureField(placeholder, text: $text)
                  .padding(.leading)
                  .font(Font.custom("NotoSerif", size: 15))
                  .autocorrectionDisabled(true).autocapitalization(.none)
              )
              .frame(height: height)
        } else {
            RoundedRectangle(cornerRadius: 10)
              .fill(.white)
              .overlay(
                TextField(placeholder, text: $text)
                  .padding(.leading)
                  .font(Font.custom("NotoSerif", size: 15))
                  .autocorrectionDisabled(true).autocapitalization(.none)
              )
              .frame(height: height)
        }
        
    }
}
