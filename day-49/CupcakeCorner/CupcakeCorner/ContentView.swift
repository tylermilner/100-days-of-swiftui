//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tyler Milner on 9/13/23.
//

import SwiftUI

// Validating and disabling forms
struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

//// Loading an image from a remote server
//struct ContentView: View {
//    var body: some View {
//        // Provide scale to render image at that exact scale
////        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
//
//        // Apply modifiers to the image when downloaded
////        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
////            image
////                .resizable()
////                .scaledToFit()
////        } placeholder: {
////            ProgressView()
////        }
////        .frame(width: 200, height: 200)
//
//        // Observe async image phases
//        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image.")
//            } else {
//                ProgressView()
//            }
//        }
//    }
//}

//// Sending and receiving Codable data with URLSession and SwiftUI
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//struct ContentView: View {
//    @State private var results = [Result]()
//
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
//    }
//
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//}

//// Adding Codable conformance for @Published properties
//class User: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    @Published var name = "Paul Hudson"
//
//    // Alternatively mark class as 'final' to remove 'required' keyword
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
