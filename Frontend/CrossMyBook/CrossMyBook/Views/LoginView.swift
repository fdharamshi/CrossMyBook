//
//  LoginView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI

struct LoginView: View {
  
  @State var email: String = ""
  @State var password: String = ""
  @State var jump = false
  
  @State var showAlert = false
  @State var alertMsg = ""
  
  @AppStorage("user_id") var userID: Int = -1
  
  func loginCompletion(_ loginModel: AuthModel) {
    if(loginModel.success) {
      guard let userIDInt = loginModel.user?.userID else {
        return
      }
      userID = userIDInt
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
          
          RoundedTextField(text: $email, placeholder: "Email", height: 48).autocorrectionDisabled(true).autocapitalization(.none)
          
          RoundedTextField(text: $password, placeholder: "Password", height: 48).autocorrectionDisabled(true).autocapitalization(.none)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        
        Button(action: {
          //          UserDefaults.standard.set(email, forKey: "user_id")
          //          jump = true
          
          LoginController().doLogin(email, password, completion: { loginModel in
            
            loginCompletion(loginModel)
            
          })
          
        }) {
          Text("Login").font(.custom("NotoSerif", size: 15).bold())
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
            .foregroundColor(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
        
        Divider().padding(EdgeInsets(top: 0, leading:20, bottom: 0, trailing:20))
        
        HStack{
          Text("Not a member?")
          NavigationLink(destination: SignupView()) {
            Text("Sign Up Now")
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          }
        }
        .font(Font.custom("NotoSerif", size: 15))
        .padding()
        
        Spacer()
        
      }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
    .navigationBarHidden(true)
    .alert(isPresented: $showAlert) {
      Alert(title: Text("Login Failed"), message: Text(alertMsg))
    }.onAppear(perform: {
      userID = -1
    })
  }
}


struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
