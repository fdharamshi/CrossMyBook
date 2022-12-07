//
//  OnBoardingScreen3.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnBoardingScreen3: View {
  @State var textOneOpacity = 0.0
  @State var textTwoOpacity = 0.0
  @State var textThreeOpacity = 0.0
  @State var textFourOpacity = 0.0
  
  var body: some View {
    VStack (alignment: .center) {
      Spacer()
      
      Image("onboardingImage3")
        .resizable()
        .frame(width: 250, height: 250)
      
      Text("How is CrossMyBook App different?")
        .multilineTextAlignment(.center)
        .font(.custom("NotoSerif", size: 25))
        .bold()
        .foregroundColor(Color.theme)
        .opacity(textOneOpacity)
      
      Text("CrossMyBook brings the amazing idea of Book Crossing to your fingertips. You can now choose whom you want to send your book to, and also request for available books on the app.")
        .padding(.horizontal, 20.0)
        .padding(.vertical, 10.0)
        .multilineTextAlignment(.center)
        .font(.custom("NotoSerif", size: 15))
        .opacity(textTwoOpacity)
      
      Text("Best Part?")
        .padding(.horizontal, 20.0)
        .bold()
        .font(.custom("NotoSerif", size: 15))
        .foregroundColor(Color.theme)
        .opacity(textThreeOpacity)
      
      Text("You can track the books on the Map. Wouldn't it be excited to see how far your book travelled or how far has the current book you're reading travelled?")
        .padding(.horizontal, 20.0)
        .multilineTextAlignment(.center)
        .font(.custom("NotoSerif", size: 15))
        .opacity(textFourOpacity)
      
      
      Spacer()
    }.onAppear(perform: {
      textOneOpacity = 0.0
      textTwoOpacity = 0.0
      textThreeOpacity = 0.0
      textFourOpacity = 0.0
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
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        withAnimation(.easeInOut(duration: 0.5)) {
          self.textFourOpacity = 1.0
        }
      }
    })
  }
}

struct OnBoardingScreen3_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingScreen3()
  }
}
