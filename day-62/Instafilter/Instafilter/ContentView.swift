//
//  ContentView.swift
//  Instafilter
//
//  Created by Tyler Milner on 9/29/23.
//

import SwiftUI

// Showing multiple options with confirmationDialog()
struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
}

//// Responding to state changes using onChange()
//struct ContentView: View {
//    @State private var blurAmount = 0.0
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//                // onChange modifier can also be applied to the VStack
//                .onChange(of: blurAmount) { newValue in
//                    print("New value is \(newValue)")
//                }
//            
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
//    }
//}

//// How property wrappers become structs
//struct ContentView: View {
//    @State private var blurAmount = 0.0 {
//        didSet {
//            // Binding used in the Slider doesn't activate this didSet
//            print("New value is \(blurAmount)")
//        }
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//            
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
