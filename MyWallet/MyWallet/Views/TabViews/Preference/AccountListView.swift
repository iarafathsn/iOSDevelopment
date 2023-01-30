//
//  AccountListView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct AccountListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var currencySetting: CurrencySetting
    @State private var showingSheet = false
    
    @ObservedObject var accountListVM: AccountListViewModel
    
    init(vm: AccountListViewModel) {
        self.accountListVM = vm
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Balance: \(self.totalBalance()) \(currencySetting.currency.code)")
                .foregroundColor(.gray)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .regular, design: .serif))
            
            List {
                ForEach(accountListVM.accounts) { account in
                    NavigationLink(destination: EditAccountView(vm: ModifyAccountViewModel(context: managedObjectContext), account: account)) {
                        HStack {
                            CellImageView(imageName: account.imageName, color: account.color)
                            
                            Text(account.name)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                }
//                .onDelete(perform: deleteAccount)
            }
            .font(.system(size: 24, weight: .semibold, design: .rounded))
        }
        .navigationViewStyle(.stack)
        .navigationTitle("Accounts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Logger.i("Add account pressed")
                    showingSheet.toggle()
                } label: {
                    Label("Add", systemImage: "plus.circle")
                }
                .sheet(isPresented: $showingSheet) {
                    AddAccountView(vm: AddAccountViewModel(context: managedObjectContext))
                }
            }
        }
    }
    
    private func totalBalance() -> String {
        var result: Double = 0.0
        
        for item in accountListVM.accounts {
            result += item.balance
        }
        
        return String(format: "%.2f", result)
    }
    
    private func deleteAccount(offsets: IndexSet) {
        withAnimation {
            offsets.forEach {index in
                let account = accountListVM.accounts[index]
                accountListVM.deleteAccount(accountId: account.id)
            }
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView(vm: AccountListViewModel(context: CoreDataModel.shared.container.viewContext))
    }
}
