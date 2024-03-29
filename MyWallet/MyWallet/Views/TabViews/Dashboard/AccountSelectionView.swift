//
//  AccountSelectionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 16/1/23.
//

import SwiftUI

struct AccountSelectionView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<AccountEntity>
    
    @State private var showingSheet = false
    
    @Binding var selectedAccount: AccountEntity?
    
    var body: some View {
        if account.count == 0 {
            VStack {
                Text("No account found")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.red)
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
                        AddAccountView(vm: AddAccountViewModel(context: managedObjectContext))
                    }
                }
            }
        }
        else {
            List {
                Section("Account") {
                    ForEach(account) { item in
                        Button {
                            selectedAccount = item
                            dismiss()
                        } label: {
                            HStack {
                                CellImageView(imageName: item.wrappedImageName, color: ColorEMHelper.getColor(colorEntity: item.color!))
                                
                                Text("\(item.wrappedName)")
                                    .font(.system(size: 24, weight: .bold))
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct AccountSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSelectionView()
//    }
//}


struct ToAccountSelectionView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<AccountEntity>
    
    @State private var showingSheet = false
    
    var exceptThisAccount: AccountEntity?
    
    @Binding var selectedAccount: AccountEntity?
    
    var body: some View {
        if account.count == 0 {
            VStack {
                Text("No account found")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.red)
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
                        AddAccountView(vm: AddAccountViewModel(context: managedObjectContext))
                    }
                }
            }
        }
        else {
            List {
                Section("Account") {
                    ForEach(account) { item in
                        if (exceptThisAccount != nil) && (item != exceptThisAccount) {
                            Button {
                                selectedAccount = item
                                dismiss()
                            } label: {
                                HStack {
                                    CellImageView(imageName: item.wrappedImageName, color: ColorEMHelper.getColor(colorEntity: item.color!))
                                    
                                    Text("\(item.wrappedName)")
                                        .font(.system(size: 24, weight: .bold))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
