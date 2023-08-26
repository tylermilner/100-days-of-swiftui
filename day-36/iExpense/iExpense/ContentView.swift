//
//  ContentView.swift
//  iExpense
//
//  Created by Tyler Milner on 8/26/23.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

// Archiving Swift objects with Codable
struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

//// Storing user settings with UserDefaults
//struct ContentView: View {
//    @AppStorage("tapCount") private var tapCount = 0
//
//    var body: some View {
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//        }
//    }
//}

//// Deleting items using onDelete()
//struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    // onDelete() only works on a `ForEach` (won't work directly on `List`)
//                    ForEach(numbers, id: \.self) {
//                        Text("Row \($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .navigationTitle("onDelete()")
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}

//// Showing and hiding views
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//
//    let name: String
//
//    var body: some View {
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "@twostraws")
//        }
//    }
//}

//// Sharing SwiftUI state with @StateObject
//class User: ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//
//struct ContentView: View {
//    @StateObject var user = User() // Use @StateObject when creating the object. Use @ObservedObject when observing an object that was created elsewhere.
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}

//// Why @State only works with structs
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
//
//struct ContentView: View {
//    @State private var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
