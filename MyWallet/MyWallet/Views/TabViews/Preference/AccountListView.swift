//
//  AccountListView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct AccountListView: View {
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Account List View")
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("Add pressed")
                        showingSheet.toggle()
                    } label: {
                        Label ("Add", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddAccountView()
                    }
                }
            }
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView()
    }
}
