//
//  AddTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 6/1/23.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add View")
                    .font(.system(size: 20, weight: .bold))
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        print("Cancel pressed")
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Add pressed")
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
