//
//  SubCategoryEntity+CoreDataProperties.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//
//

import Foundation
import CoreData


extension SubCategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubCategoryEntity> {
        return NSFetchRequest<SubCategoryEntity>(entityName: "SubCategoryEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var imageName: String?
    @NSManaged public var category: CategoryEntity?
    @NSManaged public var transactions: NSSet?

    public var wrappedName: String {
        name ?? "unknown"
    }
    
    public var wrappedImageName: String {
        imageName ?? "questionmark"
    }
    
    public var transactionArray: [TransactionEntity] {
        let set = transactions as? Set<TransactionEntity> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
}

// MARK: Generated accessors for transactions
extension SubCategoryEntity {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionEntity)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionEntity)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension SubCategoryEntity : Identifiable {

}
