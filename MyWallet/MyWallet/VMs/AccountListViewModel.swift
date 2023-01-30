//
//  AddAccountViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class AccountListViewModel: NSObject, ObservableObject {
    @Published var accounts = [AccountEntityModel]()
    
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
        } catch {
            Logger.e(error)
        }
    }
    
    func deleteAccount(accountId: NSManagedObjectID) {
        do {
            guard let record = try context.existingObject(with: accountId) as? AccountEntity else {
                return
            }
            
            context.delete(record)
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
}

extension AccountListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let accounts = controller.fetchedObjects as? [AccountEntity] else {
            return
        }
        
        self.accounts = accounts.map(AccountEntityModel.init)
    }
}

struct AccountEntityModel: Identifiable {
    
    private var account: AccountEntity
    
    init(account: AccountEntity) {
        self.account = account
    }
    
    var id: NSManagedObjectID {
        account.objectID
    }
    
    var name: String {
        account.wrappedName
    }
    
    var balance: Double {
        account.balance
    }
    
    var initialAmount: Double {
        account.initialAmount
    }
    
    var imageName: String {
        account.wrappedImageName
    }
    
    var type: String {
        account.type!
    }
    
    var color: Color {
        ColorEMHelper.getColor(colorEntity: account.color!)
    }
}
