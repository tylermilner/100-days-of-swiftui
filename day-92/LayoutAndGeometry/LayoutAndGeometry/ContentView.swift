//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tyler Milner on 11/17/23.
//

import SwiftUI

extension VerticalAlignment {
    // Not designed to be instantiated so better to make this an enum rather than a struct
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
            }
            
            VStack {
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

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
