//
//  AccountTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 23/1/23.
//

import SwiftUI

struct AccountRecordList: View {
    let account: AccountEntity
    
    var body: some View {
        VStack {
            VStack {
                Text(account.wrappedName)
                    .textCase(.uppercase)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(UtilityHelper.shared.getBalanceString(balance: account.balance)) \(UserDefaultHelper.shared.getCurrency().code)")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
            .background(Color.accentColor.opacity(0.1))
            .cornerRadius(20)
            
            List(account.transactionFromArray) { item in
                ItemListCell(transaction: item)
            }
        }
        .onAppear {
            UtilityHelper.shared.setDefaultDate()
        }
        .navigationTitle("Records")
    }
}

//struct AccountTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountTransactionView()
//    }
//}
