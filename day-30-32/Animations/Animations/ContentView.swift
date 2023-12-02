//
//  ContentView.swift
//  Animations
//
//  Created by Tyler Milner on 8/15/23.
//

import SwiftUI

// Building custom transitions using ViewModifier
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

//// Showing and hiding views with transitions
//struct ContentView: View {
//    @State private var isShowingRed = false
//
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
//
//        }
//    }
//}

//// Animating gestures
//struct ContentView: View {
//    let letters = Array("Hello, SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .default.delay(Double(num) / 20),
//                        value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
//    }
//}

//// Controlling the animation stack
//struct ContentView: View {
//    @State private var enabled = false
//
//    var body: some View {
//        Button("Tap Me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .blue : .red)
//        .animation(nil, value: enabled)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
