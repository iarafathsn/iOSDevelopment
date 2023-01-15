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
                        Logger.i("Add pressed")
                        showingSheet.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
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
