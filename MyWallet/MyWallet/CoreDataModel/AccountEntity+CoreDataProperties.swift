//
//  AccountEntity+CoreDataProperties.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//
//

import Foundation
import CoreData


extension AccountEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountEntity> {
        return NSFetchRequest<AccountEntity>(entityName: "AccountEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var balance: Double
    @NSManaged public var imageName: String?
    @NSManaged public var type: String?
    @NSManaged public var transactionsFrom: NSSet?
    @NSManaged public var transferTo: NSSet?
    @NSManaged public var color: ColorEntity?
    @NSManaged public var initialAmount: Double
    
    public var wrappedName: String {
        name ?? "unknown"
    }
    
    public var wrappedImageName: String {
        imageName ?? "questionmark"
    }

    public var transactionFromArray: [TransactionEntity] {
        let set = transactionsFrom as? Set<TransactionEntity> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
    
    public var transferToArray: [TransactionEntity] {
        let set = transferTo as? Set<TransactionEntity> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
}

// MARK: Generated accessors for transactionsFrom
extension AccountEntity {

    @objc(addTransactionsFromObject:)
    @NSManaged public func addToTransactionsFrom(_ value: TransactionEntity)

    @objc(removeTransactionsFromObject:)
    @NSManaged public func removeFromTransactionsFrom(_ value: TransactionEntity)

    @objc(addTransactionsFrom:)
    @NSManaged public func addToTransactionsFrom(_ values: NSSet)

    @objc(removeTransactionsFrom:)
    @NSManaged public func removeFromTransactionsFrom(_ values: NSSet)

}

// MARK: Generated accessors for transferTo
extension AccountEntity {

    @objc(addTransferToObject:)
    @NSManaged public func addToTransferTo(_ value: TransactionEntity)

    @objc(removeTransferToObject:)
    @NSManaged public func removeFromTransferTo(_ value: TransactionEntity)

    @objc(addTransferTo:)
    @NSManaged public func addToTransferTo(_ values: NSSet)

    @objc(removeTransferTo:)
    @NSManaged public func removeFromTransferTo(_ values: NSSet)

}

extension AccountEntity : Identifiable {

}
