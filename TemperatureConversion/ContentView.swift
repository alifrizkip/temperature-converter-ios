//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by alip on 05/06/21.
//

import SwiftUI

enum TemperatureType {
    case celcius, fahrenheit, kelvin
}

struct ContentView: View {
    @State private var fromTemp = ""
    @State private var fromTempTypeIdx = 0
    
    @State private var toTempTypeIdx = 0
    
    let temperatureTypes = ["Celcius", "Kelvin", "Fahrenheit"]
    
    var fromTempType: String {
        return temperatureTypes[fromTempTypeIdx]
    }
    var toTempType: String {
        return temperatureTypes[toTempTypeIdx]
    }
    var inputTemp: Double {
        return Double(fromTemp) ?? 0
    }
    var resultTemp: Double {
        // same
        if fromTempType == toTempType {
            return inputTemp
        }
        // C to K
        if fromTempTypeIdx == 0 && toTempTypeIdx == 1 {
            return kelvinFrom(celcius: inputTemp)
        }
        // C to F
        if fromTempTypeIdx == 0 && toTempTypeIdx == 2 {
            return fahrenheitFrom(celcius: inputTemp)
        }
        // K to C
        if fromTempTypeIdx == 1 && toTempTypeIdx == 0 {
            return celciusFrom(kelvin: inputTemp)
        }
        // F to C
        if fromTempTypeIdx == 2 && toTempTypeIdx == 0 {
            return celciusFrom(fahrenheit: inputTemp)
        }
        // K to F
        if fromTempTypeIdx == 1 && toTempTypeIdx == 2 {
            let cTemp = celciusFrom(kelvin: inputTemp)
            return fahrenheitFrom(celcius: cTemp)
        }
        // F to K
        if fromTempTypeIdx == 2 && toTempTypeIdx == 1 {
            let cTemp = celciusFrom(fahrenheit: inputTemp)
            return kelvinFrom(celcius: cTemp)
        }
        
        return 0
    }
    
    private func kelvinFrom(celcius temp: Double) -> Double {
        return temp + 273
    }
    private func fahrenheitFrom(celcius temp: Double) -> Double {
        return (temp * 9/5) + 32
    }
    private func celciusFrom(kelvin temp: Double) -> Double {
        return temp - 273.15
    }
    private func celciusFrom(fahrenheit temp: Double) -> Double {
        return (temp - 32) * 5/9
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Origin")) {
                    TextField("Input origin", text: $fromTemp)
                        .keyboardType(.decimalPad)
                    
                    Picker("Type", selection: $fromTempTypeIdx) {
                        ForEach (0 ..< temperatureTypes.count) {
                            Text("\(temperatureTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Destination")) {
                    Picker("Type", selection: $toTempTypeIdx) {
                        ForEach (0 ..< temperatureTypes.count) {
                            Text("\(temperatureTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(inputTemp, specifier: "%.2f") \(fromTempType) = \(resultTemp, specifier: "%.2f") \(toTempType)")
                }
            }
            .navigationBarTitle("Temp Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
