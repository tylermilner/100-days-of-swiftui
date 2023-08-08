//
//  ContentView.swift
//  BetterRest
//
//  Created by Tyler Milner on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text(Date.now.formatted(date: .long, time: .omitted))
    }
    
    func trivialExample() {
        var components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

//struct ContentView: View {
//    @State private var wakeUp = Date.now
//
//    var body: some View {
//        DatePicker("Please enter a time", selection: $wakeUp, in: Date.now...)
//            .labelsHidden()
//    }
//}

//struct ContentView: View {
//    @State private var sleepAmount = 8.0
//
//    var body: some View {
//        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
