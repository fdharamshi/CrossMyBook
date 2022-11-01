//
//  ContentView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>
  
  @State var username: String = ""
  @State var password: String = ""
  
  var body: some View {
    
      VStack {
        
        Spacer()
        
        Text("CrossMyBook")
          .font(Font.custom("NotoSerif", size: 40))
          .foregroundColor(Color(red: 35 / 255, green: 23 / 255, blue: 9 / 255))
        Text("The Book Crossing App")
          .font(Font.custom("NotoSerif", size: 12))
          .foregroundColor(Color(red: 35 / 255, green: 23 / 255, blue: 9 / 255))
        
        VStack {
          TextField("Username", text: $username)
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1.0)
            )
            .background(Color.white)
            
          
          TextField("Password", text: $username)
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.0)
            )
            .background(Color.white)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        
        Button(action: {
            print("Login")
        }) {
          Text("Login").font(.custom("NotoSerif", size: 15))
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
          Button("Sign Up Now", action: {})
            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
        }
        .font(Font.custom("NotoSerif", size: 15))
        .padding()
        
        Spacer()
        
        
      }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
      
    }


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
