//
//  ContentView.swift
//  HotProspects
//
//  Created by Tyler Milner on 11/7/23.
//

import SwiftUI

// Creating tabs with TabView and tabItem()
struct ContentView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1") // Name for the tab
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    // Contents for the tab item in the tab bar
                    Label("One", systemImage: "star")
                }
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

//// Reading custom values from the environment with @EnvironmentObject
//@MainActor class User: ObservableObject {
//    @Published var name = "Taylor Swift"
//}
//
//struct EditView: View {
//    // @EnvironmentObject automatically attempts to pull a User object out of the environment
//    // If it can't find a User object in the environment, then the app will crash
//    // Basically, it enforces the assumption that we've setup the app with a User object in the environment
//    @EnvironmentObject var user: User
//    
//    var body: some View {
//        TextField("Name", text: $user.name)
//    }
//}
//
//struct DisplayView: View {
//    @EnvironmentObject var user: User
//    
//    var body: some View {
//        Text(user.name)
//    }
//}
//
//struct ContentView: View {
//    @StateObject var user = User()
//    
//    var body: some View {
//        VStack {
//            EditView()
//            DisplayView()
//        }
//        .environmentObject(user)
//    }
//}

#Preview {
    ContentView()
}
