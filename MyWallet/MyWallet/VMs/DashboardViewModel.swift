//
//  DashboardViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class DashboardViewModel: NSObject, ObservableObject {
    @Published var accounts = [AccountEntityModel]()
    @Published var totalBalance: String = "0.00"
    
    private let fetchResultsController: NSFetchedResultsController<AccountEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: AccountEntity.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            
            guard let accounts = fetchResultsController.fetchedObjects else {
                return
            }
            
            self.accounts = accounts.map(AccountEntityModel.init)
            
            self.updateTotalBalance()
        } catch {
            Logger.e(error)
        }
    }
    
    private func updateTotalBalance() {
        var balance = 0.0
        
        for account in accounts {
            balance += account.balance
        }
        
        totalBalance = String(format: "%.2f", balance)
    }
}

extension DashboardViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let accounts = controller.fetchedObjects as? [AccountEntity] else {
            return
        }
        
        self.accounts = accounts.map(AccountEntityModel.init)
        
        self.updateTotalBalance()
    }
}
