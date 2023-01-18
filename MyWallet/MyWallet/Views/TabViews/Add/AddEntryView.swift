//
//  AddEntryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct AddEntryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var transactionResult: FetchedResults<Transaction>
    
    var body: some View {
        if transactionResult.count == 0 {
            ZStack {
                Circle()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.blue)
                Text("No transaction found")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
            }
        }
        else {
            List {
                ForEach(transactionResult) { item in
                    HStack {
                        if item.type! == AddType.transfer.rawValue {
                            Text("\(item.type!), withdraw")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(UtilityHelper.shared.getBalanceString(balance: item.amount))
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        else if item.type! == AddType.income.rawValue {
                            Text(item.category!)
                                .font(.title)
                            
                            Spacer()
                            
                            Text("+\(UtilityHelper.shared.getBalanceString(balance: item.amount))")
                                .font(.title)
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        else {
                            Text(item.category!)
                                .font(.title)
                            
                            Spacer()
                            
                            Text("-\(UtilityHelper.shared.getBalanceString(balance: item.amount))")
                                .font(.title)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    
                    HStack {
                        if item.type! == AddType.transfer.rawValue {
                            Text("\(item.accountID!) -> \(item.toAccountID!)")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        else {
                            Text("\(item.accountID!)")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if item.date != nil {
                            Text(UtilityHelper.shared.getDateTime(date: item.date!))
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    
                    Text(item.note ?? "")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            .navigationTitle("Records")
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
