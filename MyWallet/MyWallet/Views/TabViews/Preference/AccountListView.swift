//
//  AccountListView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct AccountListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Balance: \(self.totalBalance()) \(UserDefaultHelper.shared.getCurrency().code)")
                .foregroundColor(.gray)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .regular, design: .serif))
            
            List {
                ForEach(account) { account in
                    NavigationLink(destination: EditAccountView(account: account)) {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(UtilityHelper.shared.getColorFromDBColor(account: account))
                                Image(systemName: account.imageName!)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Text(account.name!)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete(perform: deleteAccount)
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
                    AddAccountView()
                }
            }
        }
    }
    
    private func totalBalance() -> String {
        var result: Double = 0.0
        
        for item in account {
            result += item.balance
        }
        
        let resultString = "\(Double(round(100 * result) / 100))"
        
        return resultString
    }
    
    private func deleteAccount(offsets: IndexSet) {
        withAnimation {
            offsets.map { account[$0] }.forEach(managedObjectContext.delete)
            DataController.shared.save(context: managedObjectContext)
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView()
    }
}
