//
//  OnboardingScreen1.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnboardingScreen1: View {
  
  @State private var opacity = 0.0
  
    var body: some View {
      VStack (alignment: .center) {
        Spacer()
        
        Image("bookCrossingIcon")
          .resizable()
          .frame(width: 150, height: 150)
          .cornerRadius(25)
          .shadow(radius: 5)
        
        Text("CrossMyBook")
          .font(.custom("NotoSerif", size: 35))
          .bold()
          .foregroundColor(Color.theme)
        
        Text("The Book Crossing App")
          .font(.custom("NotoSerif", size: 20))
          .foregroundColor(Color.theme)
          .opacity(opacity)
          .onAppear {
            withAnimation(.easeInOut(duration: 1.2)) {
              self.opacity = 1.0
            }
          }
        
        Spacer()
      }
    }
}

struct OnboardingScreen1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen1()
    }
}
