//
//  ContentView.swift
//  Drawing
//
//  Created by Tyler Milner on 9/7/23.
//

import SwiftUI

// Adding strokeBorder() support with InsettableShape
struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        // SwiftUI Shapes measure their coordinates from the bottom left corner rather than the top left corner, causing the direction to be reversed
        // Adjust parameters accordingly
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    var body: some View {
//        Circle()
//            .strokeBorder(.blue, lineWidth: 40)
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 40)
    }
}

//// Paths vs shapes in SwiftUI
//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}
//
//struct Arc: Shape {
//    let startAngle: Angle
//    let endAngle: Angle
//    let clockwise: Bool
//
//    func path(in rect: CGRect) -> Path {
//        // SwiftUI Shapes measure their coordinates from the bottom left corner rather than the top left corner, causing the direction to be reversed
//        // Adjust parameters accordingly
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        var path = Path()
//
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
//
//        return path
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
////        Triangle()
////            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
////            .frame(width: 300, height: 300)
//
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .stroke(.blue, lineWidth: 10)
//            .frame(width: 300, height: 300)
//    }
//}

//// Creating custom paths with SwiftUI
//struct ContentView: View {
//    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
//            // Option 1 - close subpath to complete the final point
////            path.closeSubpath()
//        }
////        .fill(.blue)
////        .stroke(.blue, lineWidth: 10)
//        // Option 2 - use StrokeStyle to round off the final point
//        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round,lineJoin: .round))
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
