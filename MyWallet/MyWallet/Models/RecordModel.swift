//
//  RecordModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData

struct RecordModel: Identifiable {
    
    private var transaction: TransactionEntity
    
    init(transaction: TransactionEntity) {
        self.transaction = transaction
    }
    
    var id: NSManagedObjectID {
        transaction.objectID
    }
    
    var account: AccountEntity {
        transaction.fromAccount!
    }
    
    var toAccount: AccountEntity? {
        transaction.toAccount
    }
    
    var subCategory: SubCategoryEntity? {
        transaction.subCategory
    }
    
    var amount: Double {
        transaction.amount
    }
    
    var date: Date {
        transaction.wrappedDate
    }
    
    var type: String {
        transaction.type!
    }
    
    var note: String? {
        transaction.note
    }
}
