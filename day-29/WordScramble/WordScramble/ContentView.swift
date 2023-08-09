//
//  ContentView.swift
//  WordScramble
//
//  Created by Tyler Milner on 8/8/23.
//

import SwiftUI

// Working with strings
struct ContentView: View {
    
    var body: some View {
        Text("")
    }
    
    func test() {
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
    }
}

// Loading resources from your app bundle
//struct ContentView: View {
//
//    var body: some View {
//        Text("")
//    }
//
//    func loadFile() {
//        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
//            if let fileContents = try? String(contentsOf: fileURL) {
//                // file loaded
//            }
//        }
//    }
//}

// Introducing List, your best friend
//struct ContentView: View {
//    let people = ["Finn", "Leia", "Luke", "Rey"]
//
//    var body: some View {
//        List {
//            Text("Static row")
//
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//
//            Text("Static row")
//        }
//        .listStyle(.grouped)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
