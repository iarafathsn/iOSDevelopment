//
//  ChartHelper.swift
//  MyWallet
//
//  Created by Arafat Hossain on 25/1/23.
//

import SwiftUI

class ChartHelper {
    var pieItems: [PieItem] = [PieItem]()
    
    func isExpenseRecords(transactions: FetchedResults<TransactionEntity>) -> Bool {
        var recordDictionary: [String: RecordElement] = [String(): RecordElement(amount: 0.0, color: .red)]
        
        for transaction in transactions {
            if transaction.type == AddType.expense.rawValue {
                let name = transaction.subCategory?.category?.wrappedName ?? "Unknown"
                
                var element = recordDictionary[name]
                
                if element != nil {
                    element!.amount += transaction.amount
                }
                else {
                    element = RecordElement(amount: transaction.amount, color: ColorEMHelper.getColor(colorEntity: (transaction.subCategory?.category?.color)!))
                }
                
                recordDictionary[name] = element
            }
        }
        
        var result = false

        pieItems.removeAll()

        for name in recordDictionary.keys {
            if name.isEmpty {
                continue
            }
                
            let element = recordDictionary[name]
            
            let pieItem = PieItem(name: name, value: (element?.amount ?? 0.0), color: (element?.color ?? .red))
            pieItems.append(pieItem)
            
            result = true
        }
        
        return result
    }
}

struct RecordElement {
    var amount: Double
    let color: Color
}
