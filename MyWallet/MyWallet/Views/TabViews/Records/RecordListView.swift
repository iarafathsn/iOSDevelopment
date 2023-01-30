//
//  AddEntryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct RecordListView: View {    
    @ObservedObject private var recordListVM: RecordListViewModel
    
    @State private var showingSheet = false
    
    init(vm: RecordListViewModel) {
        self.recordListVM = vm
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if recordListVM.transactions.count == 0 {
                    Text("No records")
                        .foregroundColor(.white)
                        .font(.title)
                }
                else {
                    List {
                        ForEach(recordListVM.transactions) { item in
                            ItemListCell(recordModel: item)
                        }
                        .onDelete(perform: deleteTransaction)
                    }
                }
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
    
    private func deleteTransaction(offsets: IndexSet) {
        withAnimation {
            offsets.forEach {index in
                let transaction = recordListVM.transactions[index]
                recordListVM.deleteRecord(recordId: transaction.id)
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView(vm: RecordListViewModel(context: CoreDataModel.shared.container.viewContext))
    }
}
