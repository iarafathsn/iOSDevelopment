//
//  DashboardView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct DashboardView: View {
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Dashboard View")
                    .foregroundColor(.red)
                    .font(.system(size: 50, weight: .bold))
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
