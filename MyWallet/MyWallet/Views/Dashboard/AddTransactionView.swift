//
//  AddTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 6/1/23.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedType = AddType.expense
    @State private var selectedAmount = 0.0
    @State private var selectedDate = Date()
    @State private var paymentType = PaymentType.cash
    @State private var enteredNote = ""
    @State private var enteredPayee = ""
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("", selection: $selectedType) {
                        ForEach(AddType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        Text("\(UserDefaultHelper.shared.getCurrency().code)")
                            .cornerRadius(10)
                            .font(.system(size: 30, weight: .semibold))
                        
                        Spacer()
                        
                        TextField("0", value: $selectedAmount, format: .number)
                            .lineLimit(1)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(self.getAmountTextColor())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                    }
                }
                
                Section("General") {
                    HStack {
                        Text("Account")
                        Spacer()
                        Text("Required")
                            .foregroundColor(.red)
                    }
                    
                    if selectedType == .transfer {
                        HStack {
                            Text("To Account")
                            Spacer()
                            Text("Required")
                                .foregroundColor(.red)
                        }
                    }
                    else {
                        HStack {
                            Text("Category")
                            Spacer()
                            Text("Required")
                                .foregroundColor(.red)
                        }
                    }
                    
                    DatePicker("Date & Time", selection: $selectedDate)
                }
                .onTapGesture {
                    isInputActive = false
                }
                
                Section("More Detail") {
                    NavigationLink(destination: AddDetail(text: $enteredNote, detailType: .note)) {
                        HStack {
                            Text("Note")
                            Spacer()
                            Text(enteredNote)
                        }
                    }
                    
                    NavigationLink(destination: AddDetail(text: $enteredPayee, detailType: .payee)) {
                        HStack {
                            Text("Payee")
                            Spacer()
                            Text(enteredPayee)
                        }
                    }
                    
                    Picker("Payment Type", selection: $paymentType) {
                        ForEach(PaymentType.allCases, id: \.self) { payType in
                            Text(payType.rawValue)
                        }
                    }
                }
                .onTapGesture {
                    isInputActive = false
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        Logger.i("Cancel pressed")
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Logger.i("Add pressed")
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func getAmountTextColor() -> Color {
        switch selectedType {
        case .expense:
            return .red
        case .income:
            return .green
        case .transfer:
            return .primary
        }
    }
}

enum AddType: String, CaseIterable {
    case expense = "Expense"
    case income = "Income"
    case transfer = "Transfer"
}

enum PaymentType: String, CaseIterable {
    case cash = "Cash"
    case debit = "Debit Card"
    case transfer = "Bank Transfer"
    case mobile = "Mobile Payment"
    case credit = "Credit Card"
    case other = "Other"
}

enum DetailType {
    case note
    case payee
}

struct AddDetail: View {
    @Environment(\.dismiss) var dismiss
    @Binding var text: String
    @FocusState private var isInputActive: Bool
    
    var detailType: DetailType
    
    var body: some View {
        VStack {
            Text("\(self.getTitle())")
            
            TextField("", text: $text)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .focused($isInputActive)
                .onSubmit {
                    Logger.i("Finished")
                    dismiss()
                }
            
            Spacer()
        }
        .onAppear {
            isInputActive = true
        }
    }
    
    private func getTitle() -> String {
        if detailType == .note {
            return "Add Note"
        }
        else {
            return "Add Payee"
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
//        AddDetail(text: .constant("Arafat"), detailType: .note)
    }
}
