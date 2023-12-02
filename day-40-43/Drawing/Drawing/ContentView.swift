//
//  ContentView.swift
//  Drawing
//
//  Created by Tyler Milner on 9/7/23.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var gradientStart = 0.0
    var gradientEnd = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStart, y: gradientEnd),
                            endPoint: UnitPoint(x: 1 - gradientStart, y: 1 - gradientEnd)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    @State private var gradientStart = 0.0
    @State private var gradientEnd = 1.0
    
    var body: some View {
        VStack {
            VStack {
                ColorCyclingRectangle(amount: colorCycle, gradientStart: gradientStart, gradientEnd: gradientEnd)
                    .frame(width: 300, height: 300)
                
                Slider(value: $colorCycle)
                
                Slider(value: $gradientStart)
                
                Slider(value: $gradientEnd)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
