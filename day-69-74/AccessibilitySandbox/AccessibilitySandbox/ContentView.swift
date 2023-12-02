//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Tyler Milner on 10/11/23.
//

import SwiftUI

// Reading the value of controls
struct ContentView: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value: \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement() // Group VStack together to treat it all as one thing
        .accessibilityLabel("Value") // Default accessibility label read during initial interaction
        .accessibilityValue(String(value)) // The text that will be read with each adjustment
        .accessibilityAdjustableAction { direction in // Which direction the user tried to adjust this control
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

//// Hiding and grouping accessibility data
//struct ContentView: View {
//    var body: some View {
////        Image(decorative: "character") // Ignore the image for accessibility purposes
////            .accessibilityHidden(true) // Explicitly set the element hidden from Voice Over
//        
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
////        .accessibilityElement(children: .combine) // Read all children in one go
//        .accessibilityElement(children: .ignore) // Ignore accessibility for the children so that we can explicitly set it
//        .accessibilityLabel("Your score is 1000") // Explicitly set the accessibility text
//    }
//}

//// Identifying views with useful labels
//struct ContentView: View {
//    let pictures = [
//        "ales-krivec-15949",
//        "galina-n-189483",
//        "kevin-horstmann-141705",
//        "nicolas-tissot-335096"
//    ]
//    
//    let labels = [
//        "Tulips",
//        "Frozen tree buds",
//        "Sunflowers",
//        "Fireworks"
//    ]
//    
//    @State private var selectedPicture = Int.random(in: 0...3)
//    
//    var body: some View {
//        Image(pictures[selectedPicture])
//            .resizable()
//            .scaledToFit()
//            .onTapGesture {
//                selectedPicture = Int.random(in: 0...3)
//            }
//            .accessibilityLabel(labels[selectedPicture])
//            .accessibilityAddTraits(.isButton)
//            .accessibilityRemoveTraits(.isImage)
//    }
//}

#Preview {
    ContentView()
}
