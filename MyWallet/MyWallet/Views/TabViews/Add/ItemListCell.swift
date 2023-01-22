//
//  ItemListCell.swift
//  MyWallet
//
//  Created by Arafat Hossain on 19/1/23.
//

import SwiftUI

struct ItemListCell: View {
    let transaction: TransactionEntity
    
    var body: some View {
        VStack {
            HStack {
                if transaction.type! == AddType.transfer.rawValue {
                    Text("\(transaction.type!), withdraw")
                        .font(.title)
                    
                    Spacer()
                    
                    Text(UtilityHelper.shared.getBalanceString(balance: transaction.amount))
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                else if transaction.type! == AddType.income.rawValue {
                    Text(transaction.subCategory?.wrappedName ?? "Unknown")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("+\(UtilityHelper.shared.getBalanceString(balance: transaction.amount))")
                        .font(.title)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                else {
                    Text(transaction.subCategory?.wrappedName ?? "Unknown")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("-\(UtilityHelper.shared.getBalanceString(balance: transaction.amount))")
                        .font(.title)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            HStack {
                if transaction.type! == AddType.transfer.rawValue {
                    Text("\(transaction.fromAccount?.wrappedName ?? "Unknown") -> \(transaction.toAccount?.wrappedName ?? "Unknown")")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                else {
                    Text(transaction.fromAccount?.wrappedName ?? "Unknown")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if transaction.date != nil {
                    Text(UtilityHelper.shared.getDateTime(date: transaction.date!))
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            Text(transaction.note ?? "")
                .foregroundColor(.gray)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct ItemListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListCell()
//    }
//}
