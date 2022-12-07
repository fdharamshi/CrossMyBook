//
//  OnBoardingScreen2.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnBoardingScreen2: View {
  
  @State var textOneOpacity = 0.0
  @State var textTwoOpacity = 0.0
  @State var textThreeOpacity = 0.0
  
    var body: some View {
      VStack (alignment: .center) {
        Spacer()
        
        Image("onboardingImage2")
          .resizable()
          .frame(width: 250, height: 250)
        
          Text("What is Book Crossing?")
            .font(.custom("NotoSerif", size: 25))
            .bold()
            .foregroundColor(Color.theme)
            .opacity(textOneOpacity)
        
          Text("BookCrossing is defined as \"the practice of leaving a book in a public place to be picked up and read by others, who then do likewise.\"")
            .padding(.horizontal, 20.0)
            .padding(.vertical, 10.0)
            .multilineTextAlignment(.center)
            .font(.custom("NotoSerif", size: 15))
            .opacity(textTwoOpacity)
        
          Text("Aiming to \"make the whole world a library.\"")
            .padding(.horizontal, 20.0)
            .font(.custom("NotoSerif", size: 15))
            .opacity(textThreeOpacity)

        
        Spacer()
      }.onAppear(perform: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textOneOpacity = 1.0
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textTwoOpacity = 1.0
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textThreeOpacity = 1.0
          }
        }
      })
    }
}

struct OnBoardingScreen2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen2()
    }
}
