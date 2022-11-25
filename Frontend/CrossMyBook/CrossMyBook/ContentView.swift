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
    
//    var loggedIn: Int = Int(UserDefaults.standard.string(forKey: "user_id") ?? "-1") ?? -1
  
  @AppStorage("user_id") var userID: Int = -1
  
//    init() {
//    loggedIn = Int(UserDefaults.standard.string(forKey: "user_id") ?? "-1") ?? -1
//    }
  
    var body: some View {
        // BookDetailView()
      
      if(userID == -1) {
        LoginView()
      } else {
        LandingView()
      }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
