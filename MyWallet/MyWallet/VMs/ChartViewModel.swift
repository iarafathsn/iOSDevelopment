//
//  ChartViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData

@MainActor
class ChartViewModel: NSObject, ObservableObject {
    @Published var pieItems: [PieItem] = [PieItem]()
    
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
            
            self.updateItem(transactions: transactions)
        } catch {
            Logger.e(error)
        }
    }
    
    private func updateItem(transactions: [TransactionEntity]) {
        // == below code needs to be updated
        
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
        
        pieItems.removeAll()

        for name in recordDictionary.keys {
            if name.isEmpty {
                continue
            }
                
            let element = recordDictionary[name]
            
            let pieItem = PieItem(name: name, value: (element?.amount ?? 0.0), color: (element?.color ?? .red))
            pieItems.append(pieItem)
        }
        
        // == above code needs to be updated
    }
}

extension ChartViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let records = controller.fetchedObjects as? [TransactionEntity] else {
            return
        }
        
        self.updateItem(transactions: records)
    }
}
