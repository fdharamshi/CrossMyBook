//
//  OnboardingScreen5.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnboardingScreen5: View {
  @State var textOneOpacity = 0.0
  @State var textTwoOpacity = 0.0
  @State var textThreeOpacity = 0.0
  
    var body: some View {
      VStack (alignment: .center) {
        Spacer()
        
        Image("onboardingImage5")
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
          .shadow(radius: 5)
        
        Text("Accepting/Declining Requests")
          .multilineTextAlignment(.center)
          .font(.custom("NotoSerif", size: 20))
          .bold()
          .foregroundColor(Color.theme)
          .opacity(textOneOpacity)
        
        Text("Once you release a book, users would send requests for that book.")
          .padding(.horizontal, 20.0)
          .padding(.vertical, 10.0)
          .multilineTextAlignment(.center)
          .font(.custom("NotoSerif", size: 15))
          .opacity(textTwoOpacity)
        
        Text("Press the bell icon to see all the requests, pending and accepted. Take action on these requests.")
          .padding(.horizontal, 20.0)
          .multilineTextAlignment(.center)
          .font(.custom("NotoSerif", size: 15))
          .opacity(textThreeOpacity)
        
        
        Spacer()
      }
      .onAppear(perform: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textOneOpacity = 1.0
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textTwoOpacity = 1.0
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.textThreeOpacity = 1.0
          }
        }
      })
    }
}

struct OnboardingScreen5_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen5()
    }
}
