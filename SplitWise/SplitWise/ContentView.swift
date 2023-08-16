//
//  ContentView.swift
//  SplitWise
//
//  Created by Štěpán Záliš on 11.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    
    @State private var tipPercentages = [0, 10, 20, 30, 40, 50]
    @State private var tipPercentage = 10
    
    @FocusState private var amountFocus: Bool
    
    @State private var showingAlert = false
    
    let currencyType = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currency?.identifier ?? "USD")

    
    var tatalToPay: Double {
        let people = Double(numberOfPeople)
        let tip = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tip
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / people
        return amountPerPerson
        
    }
    
    var totalAmount: Double {
        let tip = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tip
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Text(totalAmount, format: currencyType)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.foregroundStyle(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Tip %")
                }
                
                Section {
                    Text(tatalToPay, format: currencyType)
                } header: {
                    Text("Total amount to pay")
                }
            }
            .navigationTitle("SplitWise")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
