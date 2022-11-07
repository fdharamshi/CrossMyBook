//
//  Signup.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/7.
//

import SwiftUI

struct SignupView: View {
    
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var password: String = ""
  
    var body: some View {
        VStack {
        
        Spacer()
        
        Text("CrossMyBook")
          .font(Font.custom("NotoSerif", size: 40))
          .bold()
          .foregroundColor(Color(red: 35 / 255, green: 23 / 255, blue: 9 / 255))
        Text("The Book Crossing App")
          .font(Font.custom("NotoSerif", size: 12))
          .bold()
          .foregroundColor(Color(red: 35 / 255, green: 23 / 255, blue: 9 / 255))
        
        VStack {
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("first name", text: $firstname)
                .padding(.leading)
                .font(Font.custom("NotoSerif", size: 14))
            )
            .frame(height: 48)
            
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("last name", text: $lastname)
                .padding(.leading)
                .font(Font.custom("NotoSerif", size: 14))
            )
            .frame(height: 48)
          
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("email", text: $email)
                .padding(.leading)
                .font(Font.custom("NotoSerif", size: 14))
            )
            .frame(height: 48)
          
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("password", text: $password)
                .padding(.leading)
                .font(Font.custom("NotoSerif", size: 14))
            )
            .frame(height: 48)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        
        Button(action: {
            print("Signup")
        }) {
          Text("Sign up").font(.custom("NotoSerif", size: 15).bold())
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                .foregroundColor(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
        
        Divider().padding(EdgeInsets(top: 0, leading:20, bottom: 0, trailing:20))
        
        HStack{
          Text("Already has an account?")
          Button("Log in", action: {})
            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
        }
        .font(Font.custom("NotoSerif", size: 15))
        .padding()
        
        Spacer()
        
        
      }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
      SignupView()
    }
}
