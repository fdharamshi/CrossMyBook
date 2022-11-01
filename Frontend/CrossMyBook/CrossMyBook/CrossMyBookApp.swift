//
//  CrossMyBookApp.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/1/22.
//

import SwiftUI

@main
struct CrossMyBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
