//
//  ContentView.swift
//  Drawing
//
//  Created by Tyler Milner on 9/7/23.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    // Draw the arrow
    // Take into account `insetAmount` so that the arrow continues to fit inside of the rect when the line width changes
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangleHeight = (rect.height / 3)
        let baseWidth = max(1, floor(rect.width / 10))
        
        let baseMinX = rect.midX - (baseWidth / 2) + (insetAmount / 2)
        let baseMaxX = rect.midX + (baseWidth / 2) - (insetAmount / 2)
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: triangleHeight - insetAmount))
        path.addLine(to: CGPoint(x: baseMaxX, y: triangleHeight - insetAmount))
        path.addLine(to: CGPoint(x: baseMaxX, y: rect.maxY - insetAmount))
        path.addLine(to: CGPoint(x: baseMinX, y: rect.maxY - insetAmount))
        path.addLine(to: CGPoint(x: baseMinX, y: triangleHeight - insetAmount))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: triangleHeight - insetAmount))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + insetAmount))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ContentView: View {
    @State private var arrowLineWidth = 2.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Arrow()
                .strokeBorder(.blue, style: StrokeStyle(lineWidth: arrowLineWidth, lineCap: .round,lineJoin: .round))
            
            Button("Animate Line Width") {
                withAnimation {
                    arrowLineWidth = Double.random(in: 2...20)
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
