//
//  ContentView.swift
//  Moonshot
//
//  Created by Tyler Milner on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(showingGrid ? "List" : "Grid") {
                    showingGrid.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
