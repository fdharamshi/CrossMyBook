//
//  CustomText.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct CustomText: View {
    var s: String = "s"
    var size: Int = 24
    var color: Color = Color.fontBlack
    var body: some View {
        Text(s).font(.custom("NotoSerif", size: CGFloat(size))).foregroundColor(color)
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText()
    }
}
