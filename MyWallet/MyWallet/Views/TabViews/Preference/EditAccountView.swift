//
//  EditAccountView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

struct EditAccountView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var account: FetchedResults<Account>.Element
    
    private let typeItems = AccountTypes.items
    
    @State private var name = ""
    @State private var balance = 0.0
    @State private var type: AccountType = AccountTypes.items[0]
    @State private var color: Color = .red
    
    @FocusState var isInputActive: Bool
    
    var body: some View {
        Form {
            HStack {
                Text("Account Name")
                Spacer()
                TextField("\(account.name!)", text: $name)
                    .lineLimit(1)
                    .cornerRadius(10)
                    .multilineTextAlignment(.trailing)
                    .focused($isInputActive)
                    .onAppear {
                        name = account.name!
                    }
            }
            
            HStack {
                Text("Current Balance")
                Spacer()
                TextField("\(account.balance)", value: $balance, format: .number)
                    .lineLimit(1)
                    .cornerRadius(10)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .focused($isInputActive)
                    .onAppear {
                        balance = account.balance
                    }
            }
            
            HStack {
                Picker("Type", selection: $type) {
                    ForEach(typeItems, id: \.self) { item in
                        Text(item.name)
                    }
                }
                .onAppear {
                    if let index = typeItems.firstIndex(where: { $0.name == account.type}) {
                        type = typeItems[index]
                    }
                }
            }
            
            HStack {
                VStack {
                    ColorPicker("Color", selection: $color)
                        .onAppear {
                            color = UtilityHelper.shared.getColorFromDBColor(account: account)
                        }
                }
            }
        }
        .navigationTitle("Modify Account")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    Logger.i("Keyboard hide pressed")
                    self.hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                })
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save") {
                    Logger.i("Add pressed")

                    if name.isEmpty {
                        Logger.e("No Account Name")
                    }
                    else {
                        Logger.i("Name: \(name), Balance: \(balance), Type: \(type.name)")
                        
                        let accountModel = AccountModel(name: name, balance: balance, type: type.name, imageName: type.imageName, color: color)
                        
                        DataController.shared.editAccount(account: account, accountModel: accountModel, context: managedObjectContext)
                        
                        dismiss()
                    }
                }
            }
        }
    }
}
