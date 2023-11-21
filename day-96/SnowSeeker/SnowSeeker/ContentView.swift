//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tyler Milner on 11/20/23.
//

import SwiftUI

// Making a SwiftUI view searchable
struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        NavigationView {
//            Text("Searching for \(searchText)")
//                // Must use searchable with something that has a navigation view
//                .searchable(text: $searchText, prompt: "Look for something")
//                .navigationTitle("Searching")
            
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

//// Using groups as transparent layout containers
//struct UserView: View {
//    var body: some View {
//        // Groups the text views together so that the parent view can control the layout
//        Group {
//            Text("Name: Paul")
//            Text("Country: England")
//            Text("Pets: Luna and Arya")
//        }
//        .font(.title)
//    }
//}
//
//struct ContentView: View {
//    @Environment(\.horizontalSizeClass) var sizeClass
//    
//    var body: some View {
//        if sizeClass == .compact {
//            VStack(content: UserView.init)
//        } else {
//            HStack(content: UserView.init)
//        }
//    }
//}

//// Using alert() and sheet() with optionals
//struct User: Identifiable {
//    var id = "Taylor Swift"
//}
//
//struct ContentView: View {
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
//    
//    var body: some View {
//        Text("Hello, world!")
//            .onTapGesture {
//                selectedUser = User()
//                isShowingUser = true
//            }
//            // Sheet is automatically shown when selectedUser is non-nil and then automatically sets it to nil when dismissed
////            .sheet(item: $selectedUser) { user in
////                Text(user.id)
////            }
//        
////            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
////                Button(user.id) { }
////            }
//        
//            // By default, alert will include an "OK" button if none is specified
//            .alert("Welcome", isPresented: $isShowingUser) { }
//    }
//}

//// Working with two side by side views in SwiftUI
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
////            // First view is automatically the primary view
////            Text("Hello, world!")
////                .navigationTitle("Primary")
////            
////            // Secondary view for landscape Pro Max and iPad layouts
////            Text("Secondary")
//            
//            NavigationLink {
//                Text("New secondary")
//            } label: {
//                Text("Hello, world!")
//            }
//            .navigationTitle("Primary")
//            
//            Text("Secondary")
//            
//            // The last view here is automatically opened/navigated to when in landscape
//            Text("Tertiary")
//        }
//    }
//}

#Preview {
    ContentView()
}
