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
            if UtilityHelper.shared.isSameDay(date: transaction.wrappedDate) == false {
                Text("\(UtilityHelper.shared.getDateOnly(date: transaction.wrappedDate))")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                CellImageView(imageName: UtilityHelper.shared.getImageName(transaction: transaction), color: UtilityHelper.shared.getTransactionColor(transaction: transaction))
                
                VStack {
                    Text(UtilityHelper.shared.getTransactionTitle(transaction: transaction))
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(transaction.fromAccount?.wrappedName ?? "Unknown")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if transaction.note != nil {
                        Text(transaction.note ?? "")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                VStack {
                    if transaction.type == AddType.transfer.rawValue {
                        Text("\(UtilityHelper.shared.getBalanceString(balance: transaction.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    else if transaction.type == AddType.expense.rawValue {
                        Text("-\(UtilityHelper.shared.getBalanceString(balance: transaction.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    else {
                        Text("+\(UtilityHelper.shared.getBalanceString(balance: transaction.amount))")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Text("\(UtilityHelper.shared.getTimeOnly(date: transaction.wrappedDate))")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

//struct ItemListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListCell()
//    }
//}
