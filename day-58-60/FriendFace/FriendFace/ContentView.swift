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
    @State private var fetchedUsersFromNetwork = false
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink {
                    UserDetailView(user: user.userValue)
                } label: {
                    HStack {
                        Text(user.wrappedName)
                        
                        Spacer()
                        
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.subheadline)
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("Friend Face")
            .task {
                print("\(cachedUsers.count) users fetched from Core Data cache")
                print("Fetched users from network yet? - \(fetchedUsersFromNetwork)")
                
                if fetchedUsersFromNetwork == false {
                    await loadData()
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
            fetchedUsersFromNetwork = true
            print("Fetched \(users.count) users from network")
            
            // Queue up Core Data work to the main thread to ensure the fetch request won't change under SwiftUI's feet
            // Maybe not necessary? I wasn't actually able to reproduce any broken functionality or crashes when not using MainActor.run...
            await MainActor.run {
                // Save the data to Core Data
                for user in users {
                    // Write users to the in-memory Core Data store
                    _ = CachedUser(user: user, moc: moc)
                }
                // Write the in-memory store to disk
                try? moc.save()
                print("Saved \(users.count) users to Core Data cache")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
