//
//  ContentView.swift
//  Drawing
//
//  Created by Tyler Milner on 9/7/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangleRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height / 3)
        let triangle = Triangle()
        let trianglePath = triangle.path(in: triangleRect)
        path.addPath(trianglePath)
        
        let thickness = max(1, floor(rect.width / 10))
        let arrowMinX = triangleRect.midX - (thickness / 2)
        let arrowMaxX = triangleRect.midX + (thickness / 2)
        path.move(to: CGPoint(x: arrowMinX, y: triangleRect.maxY))
        path.addLine(to: CGPoint(x: arrowMinX, y: rect.maxY))
        path.addLine(to: CGPoint(x: arrowMaxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: arrowMaxX, y: triangleRect.maxY))
        
        return path
    }
}

struct ContentView: View {
    var body: some View {
        Arrow()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
