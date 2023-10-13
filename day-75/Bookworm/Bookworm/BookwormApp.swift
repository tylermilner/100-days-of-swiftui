//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tyler Milner on 9/16/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    // @StateObject to keep this alive throught the life of the app
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Save managed object context to the environment for other views to access
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
