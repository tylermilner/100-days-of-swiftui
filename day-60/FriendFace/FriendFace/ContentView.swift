//
//  ContentView.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/18/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
                        
                        Spacer()
                        
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.subheadline)
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("Friend Face")
            .task {
                print("\(cachedUsers.count) users fetched from Core Data")
                print("\(users.count) users currently in memory")
                
                if users.isEmpty {
                    await loadData()
                    
                    // Save the data to Core Data
                    for user in users {
                        // Write users to the in-memory Core Data store
                        _ = CachedUser(user: user, moc: moc)
                    }
                    // Write the users to disk
                    try? moc.save()
                }
            }
        }
    }
    
    private func loadData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let users = try decoder.decode([User].self, from: data)
            self.users = users
            print("Fetched \(users.count) users")
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
