//
//  TransactionEntity+CoreDataProperties.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var amount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var payee: String?
    @NSManaged public var paymentType: String?
    @NSManaged public var fromAccount: AccountEntity?
    @NSManaged public var toAccount: AccountEntity?
    @NSManaged public var subCategory: SubCategoryEntity?

    public var wrappedDate: Date {
        date ?? Date()
    }
}

extension TransactionEntity : Identifiable {

}
