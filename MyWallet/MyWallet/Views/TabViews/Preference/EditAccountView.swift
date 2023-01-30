//
//  EditAccountView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

struct EditAccountView: View {
    @Environment(\.dismiss) var dismiss
    
    var account: AccountEntityModel
    var modifyAccountVM: ModifyAccountViewModel
    
    private let typeItems = AccountTypes.items
    
    @State private var name = ""
    @State private var balance: Double = 0.0
    @State private var type: AccountType = AccountTypes.items[0]
    @State private var color: Color = .red
    @State private var isInitBalaceUpdate = true
    
    @FocusState var isInputActive: Bool
    
    init(vm: ModifyAccountViewModel, account: AccountEntityModel) {
        self.modifyAccountVM = vm
        self.account = account
    }
    
    var body: some View {
        Form {
            HStack {
                NavigationLink(destination: AddTextField(text: $name, title: "Account Name")) {
                    HStack {
                        Text("Account Name")
                            .lineLimit(1)
                            .font(.system(size: 22, weight: .semibold))
                        
                        Spacer()
                        
                        Text(name)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                            .font(.system(size: 20, weight: .regular))
                    }
                }
            }
            .onAppear {
                name = account.name
            }
            
            NavigationLink(destination: UpdateBalanceView(balance: $balance, isInitialBalance: $isInitBalaceUpdate, initialBalance: account.initialAmount, currentBalance: account.balance)) {
                HStack {
                    Text("Balance")
                    Spacer()
                    Text(String(format: "%.2f", balance))
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                if balance == 0.0 {
                    balance = account.initialAmount
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
                            color = account.color
                        }
                }
            }
        }
        .font(.system(size: 24, weight: .semibold))
        .navigationTitle("Modify Account")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save") {
                    Logger.i("Add pressed")

                    if name.isEmpty {
                        Logger.e("No Account Name")
                    }
                    else {
                        Logger.i("Name: \(name), Balance: \(balance), Type: \(type.name)")
                        
                        if isInitBalaceUpdate {
                            let accountModel = AccountModel(name: name, balance: account.balance, initialAmount: balance, type: type.name, imageName: type.imageName, color: color)
                            modifyAccountVM.modifyAccount(accountId: account.id, model: accountModel, isUpdateInitial: true)
                        }
                        else {
                            let accountModel = AccountModel(name: name, balance: balance, initialAmount: account.initialAmount, type: type.name, imageName: type.imageName, color: color)
                            modifyAccountVM.modifyAccount(accountId: account.id, model: accountModel, isUpdateInitial: false)
                        }
                        
                        dismiss()
                    }
                }
            }
        }
    }
}
