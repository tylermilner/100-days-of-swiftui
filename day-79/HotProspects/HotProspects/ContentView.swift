//
//  ContentView.swift
//  HotProspects
//
//  Created by Tyler Milner on 11/7/23.
//

import SamplePackage
import SwiftUI
import UserNotifications

// Adding Swift package dependencies in Xcode
struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        Text(results)
    }
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

//// Scheduling local notifications
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            
//            Button("Schedule Notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the dogs"
//                content.subtitle = "They look hungry"
//                content.sound = UNNotificationSound.default
//                
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//                
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
//    }
//}

//// Adding custom row swipe animations to a List
//struct ContentView: View {
//    var body: some View {
//        List {
//            Text("Taylor Swift")
//                .swipeActions {
//                    Button(role: .destructive) {
//                        print("Deleting")
//                    } label: {
//                        Label("Delete", systemImage: "minus.circle")
//                    }
//                }
//                .swipeActions(edge: .leading) {
//                    Button {
//                        print("Pinning")
//                    } label: {
//                        Label("Pin", systemImage: "pin")
//                    }
//                    .tint(.orange)
//                }
//        }
//    }
//}

//// Creating context menus
//struct ContentView: View {
//    @State private var backgroundColor = Color.red
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .padding()
//                .background(backgroundColor)
//            
//            Text("Change Color")
//                .padding()
//                .contextMenu {
//                    // Set button role to destructive to make it red
//                    Button(role: .destructive) {
//                        backgroundColor = .red
//                    } label: {
//                        Label("Red", systemImage: "checkmark.circle.fill")
//                        // Setting foreground color is ignored in a context menu
////                            .foregroundColor(.red)
//                    }
//                    
//                    Button("Green") {
//                        backgroundColor = .green
//                    }
//                    
//                    Button("Blue") {
//                        backgroundColor = .blue
//                    }
//                }
//        }
//    }
//}

//// Controlling image interpolation in SwiftUI
//struct ContentView: View {
//    var body: some View {
//        Image("example")
//            .interpolation(.none) // removes the pixel "blurring" that iOS automatically applies when scaling images up
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(.black)
//            .ignoresSafeArea()
//    }
//}

//// Understanding Swift's Result type
//struct ContentView: View {
//    @State private var output = ""
//    
//    var body: some View {
//        Text(output)
//            .task {
//                await fetchReadings()
//            }
//    }
//    
//    func fetchReadings() async {
////        do {
////            let url = URL(string: "https://hws.dev/readings.json")!
////            let (data, _) = try await URLSession.shared.data(from: url)
////            let readings = try JSONDecoder().decode([Double].self, from: data)
////            output = "Found \(readings.count) readings."
////        } catch {
////            print("Download error")
////        }
//        let fetchTask = Task { () -> String in
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            return "Found \(readings.count) readings."
//        }
//        
//        let result = await fetchTask.result
//        
////        do {
////            output = try result.get()
////        } catch {
////            print("Download error")
////        }
//        switch result {
//        case .success(let str):
//            output = str
//        case .failure(let error):
//            output = "Download error: \(error.localizedDescription)"
//        }
//    }
//}

//// Manually publishing ObservableObject changes
//@MainActor class DelayedUpdater: ObservableObject {
//    var value = 0 {
//        willSet {
//            // Same result as marking property as @Published
//            objectWillChange.send()
//        }
//    }
//    
//    init() {
//        for i in 1...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}
//
//struct ContentView: View {
//    @StateObject private var updater = DelayedUpdater()
//    
//    var body: some View {
//        Text("Value is \(updater.value)")
//    }
//}

//// Creating tabs with TabView and tabItem()
//struct ContentView: View {
//    @State private var selectedTab = "One"
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            Text("Tab 1") // Name for the tab
//                .onTapGesture {
//                    selectedTab = "Two"
//                }
//                .tabItem {
//                    // Contents for the tab item in the tab bar
//                    Label("One", systemImage: "star")
//                }
//            
//            Text("Tab 2")
//                .tabItem {
//                    Label("Two", systemImage: "circle")
//                }
//                .tag("Two")
//        }
//    }
//}

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
