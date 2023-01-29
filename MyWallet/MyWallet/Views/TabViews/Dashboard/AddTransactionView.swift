//
//  AddTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 6/1/23.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedType = AddType.expense
    @State private var selectedAmount = 0.0
    @State private var selectedDate = Date()
    @State private var paymentType = PaymentType.cash
    @State private var enteredNote = ""
    @State private var enteredPayee = ""
    
    @State private var isPresenting: Bool = false
    
    @State private var selectedAccount: AccountEntity?
    @State private var selectedToAccount: AccountEntity?
    @State private var selectedSubCategory: SubCategoryEntity?
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose transaction type", selection: $selectedType) {
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
                    NavigationLink(destination: AccountSelectionView(selectedAccount: $selectedAccount)) {
                        HStack {
                            Text("Account")
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .semibold))
                            Spacer()

                            if (selectedAccount != nil) {
                                Text(selectedAccount?.name ?? "")
                                    .lineLimit(1)
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            else {
                                Text("Required")
                                    .foregroundColor(.red)
                                    .lineLimit(1)
                                    .font(.system(size: 20, weight: .regular))
                            }
                        }
                    }
                    
                    if selectedType == .transfer {
                        NavigationLink(destination: ToAccountSelectionView(exceptThisAccount: selectedAccount, selectedAccount: $selectedToAccount)) {
                            HStack {
                                Text("To Account")
                                    .lineLimit(1)
                                    .font(.system(size: 24, weight: .semibold))
                                Spacer()
                                
                                if (selectedToAccount != nil) {
                                    Text(selectedToAccount?.name ?? "")
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20, weight: .regular))
                                }
                                else {
                                    Text("Required")
                                        .foregroundColor(.red)
                                        .lineLimit(1)
                                        .font(.system(size: 20, weight: .regular))
                                }
                            }
                        }
                    }
                    else {
                        NavigationLink(destination: CategorySelectionView(selectedSubCategory: $selectedSubCategory, isPresenting: $isPresenting), isActive: $isPresenting) {
                            HStack {
                                Text("Category")
                                    .lineLimit(1)
                                    .font(.system(size: 24, weight: .semibold))
                                
                                Spacer()
                                
                                if (selectedSubCategory != nil) {
                                    Text(selectedSubCategory?.name ?? "")
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20, weight: .regular))
                                }
                                else {
                                    Text("Required")
                                        .foregroundColor(.red)
                                        .lineLimit(1)
                                        .font(.system(size: 20, weight: .regular))
                                }
                            }
                        }
                    }
                    
                    DatePicker("Date & Time", selection: $selectedDate)
                }
                
                Section("More Detail") {
                    NavigationLink(destination: AddDetail(text: $enteredNote, detailType: .note)) {
                        HStack {
                            Text("Note")
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                            
                            Spacer()
                            
                            Text(enteredNote)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .regular))
                        }
                    }
                    
                    NavigationLink(destination: AddDetail(text: $enteredPayee, detailType: .payee)) {
                        HStack {
                            Text("Payee")
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                            
                            Spacer()
                            
                            Text(enteredPayee)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .regular))
                        }
                    }
                    
                    Picker("Payment Type", selection: $paymentType) {
                        ForEach(PaymentType.allCases, id: \.self) { payType in
                            Text(payType.rawValue)
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                        }
                    }
                    .lineLimit(1)
                    .font(.system(size: 22, weight: .semibold))
                }
            }
            .navigationBarTitle("Add \(selectedType.rawValue)")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        Logger.i("Keyboard hide pressed")
                        isInputActive = false
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    })
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        Logger.i("Cancel pressed")
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Logger.i("Add pressed")
                        
                        if selectedType == .transfer {
                            Logger.i("Type: \(selectedType.rawValue) Amount: \(selectedAmount) Account: \(selectedAccount?.name ?? "Unknown") To Account: \(selectedToAccount?.name ?? "Unknown") Date: \(selectedDate) Note: \(enteredNote) Payee: \(enteredPayee) PaymentType: \(paymentType)")
                            
                            if selectedAccount != nil || selectedToAccount != nil {
                                let transactionModel = TransactionModel(account: selectedAccount!, amount: selectedAmount, type: selectedType.rawValue, subcategory: nil, date: selectedDate, note: enteredNote, payee: enteredPayee, paymentType: paymentType.rawValue, toAccount: selectedToAccount)
                                
                                CoreDataModel.shared.addTransaction(transactionModel: transactionModel, context: managedObjectContext)
                            }
                        }
                        else {
                            Logger.i("Type: \(selectedType.rawValue) Amount: \(selectedAmount) Account: \(selectedAccount?.name ?? "Unknown") Category: \(selectedSubCategory?.name ?? "Unknown") Date: \(selectedDate) Note: \(enteredNote) Payee: \(enteredPayee) PaymentType: \(paymentType)")
                            
                            if selectedAccount != nil || selectedSubCategory != nil {
                                let transactionModel = TransactionModel(account: selectedAccount!, amount: selectedAmount, type: selectedType.rawValue, subcategory: selectedSubCategory, date: selectedDate, note: enteredNote, payee: enteredPayee, paymentType: paymentType.rawValue, toAccount: nil)
                                
                                CoreDataModel.shared.addTransaction(transactionModel: transactionModel, context: managedObjectContext)
                            }
                        }
                        
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
                .font(.system(size: 24, weight: .semibold))
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
