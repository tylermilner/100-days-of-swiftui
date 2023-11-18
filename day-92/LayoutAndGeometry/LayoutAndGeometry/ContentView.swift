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
//        GeometryReader { fullView in
//            ScrollView {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
//                            .rotation3DEffect(
//                                .degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0)
//                            )
//                    }
//                    .frame(minHeight: 40)
//                }
//            }
//        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

//// Understanding frames and coordinates
//struct OuterView: View {
//    var body: some View {
//        VStack {
//            Text("Top")
//            InnerView()
//                .background(.green)
//            Text("Bottom")
//        }
//    }
//}
//
//struct InnerView: View {
//    var body: some View {
//        HStack {
//            Text("Left")
//            
//            GeometryReader { geo in
//                Text("Center")
//                    .background(.blue)
//                    .onTapGesture {
//                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
//                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
//                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
//                    }
//            }
//            .background(.orange)
//            
//            Text("Right")
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
////        VStack {
////            // GeometryReader automatically expands to fill the entire space
////            GeometryReader { geo in
////                Text("Hello, world!")
////                    .frame(width: geo.size.width * 0.9)
////                    .background(.red)
////            }
////            .background(.green)
////            
////            Text("More text")
////            Text("More text")
////            Text("More text")
////            Text("More text")
////            Text("More text")
////                .background(.blue)
////        }
//        
//        OuterView()
//            .background(.red)
//            .coordinateSpace(name: "Custom")
//    }
//}

//// Absolute positioning for SwiftUI views
//struct ContentView: View {
//    var body: some View {
////        Text("Hello, world!")
////            // .position modifier takes up all available space so that it can ensure it can layout it's child (Text) properly
////            // This causes the .background(red) to take up the full screen
////            .position(x: 100, y: 100)
////            .background(.red)
//        
//        Text("Hello, world!")
//            .offset(x: 100, y: 100)
//            .background(.red)
//    }
//}

//extension VerticalAlignment {
//    // Not designed to be instantiated so better to make this an enum rather than a struct
//    enum MidAccountAndName: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            context[.top]
//        }
//    }
//    
//    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
//}
//
//struct ContentView: View {
//    var body: some View {
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                Image("paul-hudson")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//            }
//            
//            VStack {
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//                Text("Full name:")
//                Text("PAUL HUDSON")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                    .font(.largeTitle)
//            }
//        }
//    }
//}

//// Alignment and alignment guides
//struct ContentView: View {
//    var body: some View {
////        Text("Hello, world!")
////            .frame(width: 300, height: 300, alignment: .topLeading)
////            .offset(x: 50, y: 50)
//        
////        HStack(alignment: .lastTextBaseline) {
////            Text("Live")
////                .font(.caption)
////            Text("long")
////            Text("and")
////                .font(.title)
////            Text("prosper")
////                .font(.largeTitle)
////        }
//        
////        VStack(alignment: .leading) {
////            Text("Hello, world!")
////                // Manually modify the leading alignment guide to cause the VStack to expand
////                .alignmentGuide(.leading) { d in
////                    d[.trailing]
////                }
////                // VStack does not expand with .offset modifier
//////                .offset(x: -100, y: 0)
////            Text("This is a longer line of text")
////        }
////        .background(.red)
////        .frame(width: 400, height: 400)
////        .background(.blue)
//        
//        VStack(alignment: .leading) {
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading) { _ in
//                        Double(position) * -10
//                    }
//            }
//        }
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.blue)
//    }
//}

//// How layout works in SwiftUI
//struct ContentView: View {
//    var body: some View {
//        // SwiftUI views ask their children for layout/size preference
//        // Text is the childmost view and the only one that has a hard size requirement
//        // .padding adds size to Text's requested size
//        // .background takes that suggested size and provides it to ContentView, which provides it to SwiftUI
//        Text("Hello, world!")
//            .padding(20)
//            .background(.red)
//    }
//}

#Preview {
    ContentView()
}
