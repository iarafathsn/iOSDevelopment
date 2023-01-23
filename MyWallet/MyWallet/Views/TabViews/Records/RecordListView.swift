//
//  AddEntryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct RecordListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var transactionResult: FetchedResults<TransactionEntity>
    
    @State private var showingSheet = false
    
    var body: some View {
        if transactionResult.count == 0 {
            ZStack {
                Circle()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.blue)
                Text("No transaction found")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
            }
        }
        else {
            NavigationView {
                List(transactionResult) { item in
                    ItemListCell(transaction: item)
    //                ForEach(transactionResult) { item in
    //                    ItemListCell(transaction: item)
    //                }
    //                .onDelete(perform: deleteTransaction)
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
                .onAppear {
                    UtilityHelper.shared.setDefaultDate()
                }
                .navigationTitle("Records")
            }
        }
    }
    
    private func deleteTransaction(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactionResult[$0] }.forEach(managedObjectContext.delete)
            DataController.shared.save(context: managedObjectContext)
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
