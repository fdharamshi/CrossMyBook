//
//  OnboardingScreen6.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnboardingScreen6: View {
    var body: some View {
      VStack (alignment: .center) {
        Spacer()
        
        Text("Get Started")
          .font(.custom("NotoSerif", size: 35))
          .bold()
          .foregroundColor(Color.theme)
        
        Image("onboardingImage6")
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 150)
        
        Spacer()
      }
    }
}

struct OnboardingScreen6_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen6()
    }
}
