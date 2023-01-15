//
//  DashboardView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<Account>
    
    @State private var showingSheet = false
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Balance")
                        .font(.system(size: 24, weight: .bold))
                    
                    Text("\(currency) \(UtilityHelper.shared.totalBalance(account: account))")
                }
                
                Section {
                    AccountCellView(account: _account)
                }
            }
            .onAppear {
                Logger.i("Appearing Dashboard view")
                currency = UserDefaultHelper.shared.getCurrency().code
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Logger.i("Add Transaction pressed")
                        showingSheet.toggle()
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddTransactionView()
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
