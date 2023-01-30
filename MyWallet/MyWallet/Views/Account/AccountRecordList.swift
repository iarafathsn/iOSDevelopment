//
//  AccountTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 23/1/23.
//

import SwiftUI

struct AccountRecordList: View {
    @EnvironmentObject var currencySetting: CurrencySetting
    
    let account: AccountEntityModel
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text(account.name)
                        .textCase(.uppercase)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(account.balanceString) \(currencySetting.currency)")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .listStyle(.plain)
            }
            
            Section {
                ForEach(account.transactions) { item in
                    ItemListCell(recordModel: item)
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
