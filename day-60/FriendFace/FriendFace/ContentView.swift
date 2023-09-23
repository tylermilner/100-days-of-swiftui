//
//  ContentView.swift
//  FriendFace
//
//  Created by Tyler Milner on 9/18/23.
//

import SwiftUI

struct ContentView: View {
    @State var users: [User] = []
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await loadData()
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
