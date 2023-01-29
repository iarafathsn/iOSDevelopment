//
//  AccountTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 23/1/23.
//

import SwiftUI

struct AccountRecordList: View {
    @EnvironmentObject var currencySetting: CurrencySetting
    
    let account: AccountEntity
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text(account.wrappedName)
                        .textCase(.uppercase)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(UtilityHelper.shared.getBalanceString(balance: account.balance)) \(currencySetting.currency.code)")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .listStyle(.plain)
            }
            
            Section {
                ForEach(account.transactionFromArray) { item in
                    ItemListCell(recordModel: RecordModel(transaction: item))
                }
            }
        }
        .listStyle(.plain)
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
