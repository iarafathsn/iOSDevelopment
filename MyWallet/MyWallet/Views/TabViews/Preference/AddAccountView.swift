//
//  AddAccountView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var addAccountVM: AddAccountViewModel
    
    private let typeItems = AccountTypes.items
    
    @State private var accountColor: Color = .red
    @State private var accountType: AccountType = AccountTypes.items[0]
    @State private var accountName: String = "Cash"
    @State private var accountBalance = 0.0
    @FocusState var isInputActive: Bool
    
    init(vm: AddAccountViewModel) {
        self.addAccountVM = vm
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    NavigationLink(destination: AddTextField(text: $accountName, title: "Account Name")) {
                        HStack {
                            Text("Account Name")
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                            
                            Spacer()
                            
                            Text(accountName)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .regular))
                        }
                    }
                }
                
                HStack {
                    NavigationLink(destination: AddNumberField(number: $accountBalance, title: "Current Balance")) {
                        HStack {
                            Text("Current Balance")
                                .lineLimit(1)
                                .font(.system(size: 22, weight: .semibold))
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", accountBalance))
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .regular))
                        }
                    }
                }
                
                HStack {
                    Picker("Type", selection: $accountType) {
                        ForEach(typeItems, id: \.self) { item in
                            Text(item.name)
                        }
                    }
                }
                
                HStack {
                    VStack {
                        ColorPicker("Color", selection: $accountColor)
                    }
                }
            }
            .navigationTitle("Add Account")
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

                        if accountName.isEmpty {
                            Logger.e("No Account Name")
                        }
                        else {
                            Logger.i("Name: \(accountName), Balance: \(accountBalance), Type: \(accountType.name)")
                            
                            let accountModel = AccountModel(name: accountName, balance: accountBalance, initialAmount: accountBalance, type: accountType.name, imageName: accountType.imageName, color: accountColor)
                            
                            addAccountVM.addAccount(model: accountModel)

                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView(vm: AddAccountViewModel(context: CoreDataModel.shared.container.viewContext))
    }
}
