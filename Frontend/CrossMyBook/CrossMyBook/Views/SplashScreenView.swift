//
//  SwiftUIView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/29/22.
//

import SwiftUI

struct SplashScreenView: View {
  
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
  
    @AppStorage("user_id") var userID: Int = -1
  
    var body: some View {
      if(isActive) {
        if(userID == -1) {
          LoginView()
        } else {
          LandingView()
        }
      } else {
        ZStack {
          Image("MapBackground")
            .opacity(0.4)
          VStack {
            Image("bookCrossingIcon")
              .resizable()
              .frame(width: 150, height: 150)
              .cornerRadius(25)
            Text("Book Crossing\nApp")
              .font(.custom("NotoSerif", size: 25).bold())
              .foregroundColor(Color.lightBrown)
              .multilineTextAlignment(.center)
          }.scaleEffect(size)
            .onAppear {
              withAnimation(.easeIn(duration: 1.2)) {
                self.size = 0.9
                self.opacity = 1.0
              }
            }
        }.background(Color.black).onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isActive = true
          }
        }
      }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
