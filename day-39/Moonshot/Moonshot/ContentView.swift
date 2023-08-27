//
//  ContentView.swift
//  Moonshot
//
//  Created by Tyler Milner on 8/27/23.
//

import SwiftUI

// How to lay out views in a scrolling grid
struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        // Vertical layout
//        ScrollView {
//            LazyVGrid(columns: layout) {
//                ForEach(0..<1000) {
//                    Text("Item \($0)")
//                }
//            }
//        }
        
        // Horizontal layout
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

//// Working with hierarchical Codable data
//struct User: Codable {
//    let name: String
//    let address: Address
//}
//
//struct Address: Codable {
//    let street: String
//    let city: String
//}
//
//struct ContentView: View {
//    var body: some View {
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555, Taylor Swift Avenue",
//                    "city": "Nashville"
//                }
//            }
//            """
//
//            let data = Data(input.utf8)
//
//            if let user = try? JSONDecoder().decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
//    }
//}

//// Pushing new views onto the stack using NavigationLink
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            List(0..<100) { row in
//                // SwiftUI automatically renders disclosure arrows for NavigationLinks inside a List
//                NavigationLink {
//                    Text("Detail \(row)")
//                } label: {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationTitle("SwiftUI")
//        }
//    }
//}

//// How ScrollView lets us work with scrolling data
//struct CustomText: View {
//    let text: String
//
//    var body: some View {
//        Text(text)
//    }
//
//    init(_ text: String) {
//        print("Creating a new CustomText")
//        self.text = text
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal) {
//            // Lazy stacks automatically take up full width/height vs regular stacks only take up as much space as their content
//            LazyHStack(spacing: 10) {
//                ForEach(0..<100) {
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//    }
//}

//// Resizing images to fit the screen using GeometryReader
//struct ContentView: View {
//    var body: some View {
//        GeometryReader { geo in
//            Image("Example")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.8)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
