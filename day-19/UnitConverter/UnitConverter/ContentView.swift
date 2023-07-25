//
//  ContentView.swift
//  UnitConverter
//
//  Created by Tyler Milner on 7/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @State private var inputValue = ""
    
    private let units = ["Celsius", "Fahrenheit", "Kelvin"]
    private let kelvinOffset = 273.15
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Input temperature", text: $inputValue)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    if let tempInKelvin = convertToKelvin(inputValue, inputUnit: inputUnit), let outputTemp = convertKelvin(tempInKelvin, to: outputUnit) {
                        Text("\(outputTemp.formatted())")
                    }
                } header: {
                    Text("Output")
                }
            }
        }
    }
    
    func convertToKelvin(_ input: String, inputUnit: String) -> Double? {
        guard let input = Double(input) else { return nil }
        
        switch inputUnit {
        case "Celsius":
            return input + kelvinOffset
        case "Fahrenheit":
            return (input - 32) * (5/9) + kelvinOffset
        case "Kelvin":
            return input
        default:
            return nil
        }
    }
    
    func convertKelvin(_ input: Double, to outputUnit: String) -> Double? {
        switch outputUnit {
        case "Celsius":
            return input - kelvinOffset
        case "Fahrenheit":
            return (input - kelvinOffset) * (9/5) + 32
        case "Kelvin":
            return input
        default:
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
