//
//  ContentView.swift
//  Instafilter
//
//  Created by Tyler Milner on 9/29/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

// How to save images to the user's photo library
struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePicker(image: $inputImage)
        })
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

//// Using coordinators to manage SwiftUI view controllers
//struct ContentView: View {
//    @State private var image: Image?
//    @State private var inputImage: UIImage?
//    @State private var showingImagePicker = false
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//            
//            Button("Select Image") {
//                showingImagePicker = true
//            }
//        }
//        .sheet(isPresented: $showingImagePicker, content: {
//            ImagePicker(image: $inputImage)
//        })
//        .onChange(of: inputImage) { _ in loadImage() }
//    }
//    
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//    }
//}

//// Wrapping a UIViewController in a SwiftUI view
//struct ContentView: View {
//    @State private var image: Image?
//    @State private var showingImagePicker = false
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//            
//            Button("Select Image") {
//                showingImagePicker = true
//            }
//        }
//        .sheet(isPresented: $showingImagePicker, content: {
//            ImagePicker()
//        })
//    }
//}

//// Integrating Core Image with SwiftUI
//struct ContentView: View {
//    @State private var image: Image?
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//    }
//    
//    func loadImage() {
//        guard let inputImage = UIImage(named: "Example") else { return }
//        let beginImage = CIImage(image: inputImage)
//        
//        let context = CIContext()
//        // Sepia filter
////        let currentFilter = CIFilter.sepiaTone()
////        currentFilter.inputImage = beginImage
////        currentFilter.intensity = 1
//        
//        // Pixellate filter
////        let currentFilter = CIFilter.pixellate()
////        currentFilter.inputImage = beginImage
////        currentFilter.scale = 100
//        
//        // Crystallize filter
////        let currentFilter = CIFilter.crystallize()
////        currentFilter.inputImage = beginImage
////        currentFilter.radius = 100
//        
//        // Twirl distortion filter
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//        
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//        
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//        }
//        
//        if inputKeys.contains(kCIInputRadiusKey) {
//            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
//        }
//        
//        if inputKeys.contains(kCIInputScaleKey) {
//            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
//        }
//        
//        guard let outputImage = currentFilter.outputImage else { return }
//        
//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//            let uiImage = UIImage(cgImage: cgimg)
//            image = Image(uiImage: uiImage)
//        }
//    }
//}

//// Showing multiple options with confirmationDialog()
//struct ContentView: View {
//    @State private var showingConfirmation = false
//    @State private var backgroundColor = Color.white
//    
//    var body: some View {
//        Text("Hello, world!")
//            .frame(width: 300, height: 300)
//            .background(backgroundColor)
//            .onTapGesture {
//                showingConfirmation = true
//            }
//            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
//                Button("Red") { backgroundColor = .red }
//                Button("Green") { backgroundColor = .green }
//                Button("Blue") { backgroundColor = .blue }
//                Button("Cancel", role: .cancel) { }
//            } message: {
//                Text("Select a new color")
//            }
//    }
//}

//// Responding to state changes using onChange()
//struct ContentView: View {
//    @State private var blurAmount = 0.0
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//                // onChange modifier can also be applied to the VStack
//                .onChange(of: blurAmount) { newValue in
//                    print("New value is \(newValue)")
//                }
//            
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
//    }
//}

//// How property wrappers become structs
//struct ContentView: View {
//    @State private var blurAmount = 0.0 {
//        didSet {
//            // Binding used in the Slider doesn't activate this didSet
//            print("New value is \(blurAmount)")
//        }
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//            
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
