//
//  DashboardView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<AccountEntity>
    
    @State private var showingSheet = false
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Balance")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(currency) \(UtilityHelper.shared.totalBalance(account: account))")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Section {
                    List {
                        ForEach(account) { item in
                            NavigationLink(destination: AccountTransactionView(account: item)) {
                                DAccountCell(account: item)
                            }
                        }
                    }
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
