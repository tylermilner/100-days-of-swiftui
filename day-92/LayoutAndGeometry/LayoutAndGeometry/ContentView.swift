//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tyler Milner on 11/17/23.
//

import SwiftUI

// ScrollView effects using GeometryReader
struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(min(1, max(0, geo.frame(in: .global).minY / 200)))
                            .scaleEffect(x: min(1, max(0.5, geo.frame(in: .global).minY / 200)), y: min(1, max(0.5, geo.frame(in: .global).minY / 200)))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
