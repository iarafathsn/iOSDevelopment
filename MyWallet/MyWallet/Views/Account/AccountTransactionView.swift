//
//  AccountTransactionView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 23/1/23.
//

import SwiftUI

struct AccountTransactionView: View {
    let account: AccountEntity
    
    @State var lastDate = Date()
    
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
            
            List(account.transactionFromArray) { item in
                VStack {
                    if isSameDay(date: item.wrappedDate) == false {
                        Text("\(UtilityHelper.shared.getDateOnly(date: item.wrappedDate))")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack {
                        Image(systemName: getImageName(transaction: item))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .padding(10)
                            .background(getTransactionColor(transaction: item))
                            .cornerRadius(10)
                        
                        VStack {
                            Text(getTransactionTitle(transaction: item))
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(item.paymentType ?? "Unknown")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(item.note ?? "")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack {
                            if item.type == AddType.transfer.rawValue {
                                Text("\(UtilityHelper.shared.getBalanceString(balance: item.amount))")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            else if item.type == AddType.expense.rawValue {
                                Text("-\(UtilityHelper.shared.getBalanceString(balance: item.amount))")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            else {
                                Text("+\(UtilityHelper.shared.getBalanceString(balance: item.amount))")
                                    .font(.title)
                                    .foregroundColor(.green)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            Text("\(UtilityHelper.shared.getTimeOnly(date: item.wrappedDate))")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
        }
    }
    
    func getTransactionColor(transaction: TransactionEntity) -> Color {
        if transaction.type == AddType.transfer.rawValue {
            return ColorEMHelper.getColor(colorEntity: (transaction.toAccount?.color)!)
        }
        else {
            return ColorEMHelper.getColor(colorEntity: (transaction.subCategory?.category?.color)!)
        }
    }
    
    func getTransactionTitle(transaction: TransactionEntity) -> String {
        if transaction.type == AddType.transfer.rawValue {
            return "Transfer"
        }
        else {
            return transaction.subCategory?.wrappedName ?? "Unknown"
        }
    }
    
    func getImageName(transaction: TransactionEntity) -> String {
        if transaction.type == AddType.transfer.rawValue {
            return "arrow.left.arrow.right"
        }
        else {
            return transaction.subCategory?.wrappedImageName ?? "arrow.counterclockwise"
        }
    }
    
    func isSameDay(date: Date) -> Bool {
        let order = Calendar.current.compare(date, to: lastDate, toGranularity: .hour)
        lastDate = date
        
        if order == .orderedSame {
            return true
        }
        else {
            return false
        }
    }
}

//struct AccountTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountTransactionView()
//    }
//}
