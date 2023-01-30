//
//  ChartViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData

@MainActor
class RecordListViewModel: NSObject, ObservableObject {
    @Published var transactions = [RecordModel]()
    
    private let fetchResultsController: NSFetchedResultsController<TransactionEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: TransactionEntity.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            
            guard let transactions = fetchResultsController.fetchedObjects else {
                return
            }
            
            self.transactions = transactions.map(RecordModel.init)
        } catch {
            Logger.e(error)
        }
    }
    
    func deleteRecord(recordId: NSManagedObjectID) {
        do {
            guard let record = try context.existingObject(with: recordId) as? TransactionEntity else {
                return
            }
            
            context.delete(record)
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
}

extension RecordListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let records = controller.fetchedObjects as? [TransactionEntity] else {
            return
        }
        
        self.transactions = records.map(RecordModel.init)
    }
}

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
