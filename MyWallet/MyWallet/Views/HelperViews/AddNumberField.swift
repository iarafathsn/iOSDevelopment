//
//  AddNumberField.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import SwiftUI

struct AddNumberField: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isInputActive: Bool
    @State private var numberType = NumberType.Positive
    
    @Binding var number: Double
    
    var title: String?
    var isEnableType: Bool?
    
    var body: some View {
        Form {
            if let title = self.title {
                Section {
                    Text(title)
                        .font(.system(size: 24, weight: .semibold))
                }
            }
            
            Section {
                if let type = isEnableType {
                    if type == true {
                        Picker("Choose transaction type", selection: $numberType) {
                            ForEach(NumberType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                else {
                    Picker("Choose transaction type", selection: $numberType) {
                        ForEach(NumberType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                TextField("", value: $number, format: .number)
                    .lineLimit(2)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(self.getColor())
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .focused($isInputActive)
                    .onSubmit {
                        Logger.i("Finished")
                        dismiss()
                    }
            }
        }
        .onAppear {
            isInputActive = true
            
            if number < 0 {
                numberType = .Negative
            }
        }
        .onDisappear {
            if numberType == .Negative {
                number *= -1
            }
        }
    }
    
    private func getColor() -> Color {
        if numberType == .Negative {
            return Color.red
        }
        else {
            return Color.green
        }
    }
}

enum NumberType: String, CaseIterable {
    case Positive
    case Negative
}

struct AddNumberField_Previews: PreviewProvider {
    @State static var value = 0.0
    
    static var previews: some View {
        AddNumberField(number: $value, title: "Title")
    }
}
