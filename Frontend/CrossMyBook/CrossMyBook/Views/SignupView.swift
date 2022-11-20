//
//  Signup.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/7.
//

import SwiftUI

struct SignupView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var firstname: String = ""
  @State var lastname: String = ""
  @State var email: String = ""
  @State var password: String = ""
  
  @State var jump = false
  @State var showAlert = false
  @State var alertMsg = ""
  
  func loginCompletion(_ loginModel: AuthModel) {
    if(loginModel.success) {
      
      UserDefaults.standard.set(String(loginModel.user?.userID ?? -1), forKey: "user_id")
      UserDefaults.standard.set(loginModel.user?.firstName, forKey: "first_name")
      UserDefaults.standard.set(loginModel.user?.lastName, forKey: "last_name")
      UserDefaults.standard.set(loginModel.user?.profilePicture, forKey: "photo_url")
      print("Login Success!")
      jump = true
    } else {
      alertMsg = loginModel.msg
      showAlert = true
    }
  }
  
  var body: some View {
    NavigationView {
      VStack {
        
        NavigationLink(destination: LandingView(), isActive: $jump) {
          EmptyView()
        }
        
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
          
          RoundedTextField(text: $firstname, placeholder: "First name", height: 48)
          
          RoundedTextField(text: $lastname, placeholder: "Last name", height: 48)
          
          RoundedTextField(text: $email, placeholder: "Email", height: 48)
          
          RoundedTextField(text: $password, placeholder: "Password", height: 48)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        
        Button(action: {
          LoginController().doSignup(email, password, firstname, lastname, completion: { loginModel in
            
            loginCompletion(loginModel)
            
          })
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
          
          
          Button("Log in", action: {
            self.presentationMode.wrappedValue.dismiss()
          })
          .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          
        }
        .font(Font.custom("NotoSerif", size: 15))
        .padding()
        
        Spacer()
        
        
      }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
    .navigationBarHidden(true)
    .alert(isPresented: $showAlert) {
      Alert(title: Text("Signup Failed"), message: Text(alertMsg))
    }
  }
}

struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    SignupView()
  }
}
