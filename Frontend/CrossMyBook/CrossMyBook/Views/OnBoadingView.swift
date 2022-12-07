//
//  OnBoadingView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/6/22.
//

import SwiftUI

struct OnBoadingView: View {
  
  private let onBoardingScreens: [Any] = [OnboardingScreen1.self, OnBoardingScreen2.self, OnBoardingScreen3.self, OnboardingScreen4.self, OnboardingScreen5.self, OnboardingScreen6.self]
  
  @State var currentIndex: Int = 0
  
  @State var isActive: Bool = false
  
  @AppStorage("onboardingDone") var onBoardingDone:Bool = false
  
  var body: some View {
    
    if(isActive) {
      LoginView()
    } else {
      VStack {
        TabView(selection: $currentIndex) {
          ForEach(0..<onBoardingScreens.count) {
            index in
            buildView(index)
          }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
        HStack {
          ForEach(0..<onBoardingScreens.count) {
            index in
            if(index == currentIndex) {
              Rectangle()
                .frame(width: 20, height: 10)
                .cornerRadius(10)
                .foregroundColor(.theme)
            } else {
              Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.gray)
            }
          }
        }.padding(.bottom, 20.0)
        
        HStack {
          if(currentIndex != 0) {
            Button(action: {
              if(self.currentIndex > 0) {
                self.currentIndex -= 1
              } else {
                // Hide previous button
              }
            }) {
              
              Text("Previous").font(.custom("NotoSerif", size: 15).bold())
                .padding()
                .foregroundColor(Color.theme)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.theme))
            }
            .padding(.trailing, 20.0)
          }
          
          Button(action: {
            if(self.currentIndex < self.onBoardingScreens.count - 1) {
              self.currentIndex += 1
            } else {
              // Get Started Logic
              onBoardingDone = true
              isActive = true
            }
          }) {
            Text(currentIndex == onBoardingScreens.count - 1 ? "Get Started" : "Next").font(.custom("NotoSerif", size: 15).bold())
              .padding()
              .frame(maxWidth: .infinity)
              .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
              .foregroundColor(Color.white)
          }
        }.padding(.horizontal, 20.0)
      }
    }
  }
  
  func buildView(_ index: Int) -> AnyView {
    switch onBoardingScreens[index].self {
    case is OnboardingScreen1.Type: return AnyView( OnboardingScreen1() )
    case is OnBoardingScreen2.Type: return AnyView( OnBoardingScreen2() )
    case is OnBoardingScreen3.Type: return AnyView( OnBoardingScreen3() )
    case is OnboardingScreen4.Type: return AnyView( OnboardingScreen4() )
    case is OnboardingScreen5.Type: return AnyView( OnboardingScreen5() )
    case is OnboardingScreen6.Type: return AnyView( OnboardingScreen6() )
    default: return AnyView(EmptyView())
    }
  }
}

struct OnBoadingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoadingView()
  }
}
