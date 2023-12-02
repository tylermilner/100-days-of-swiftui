//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/18/23.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
