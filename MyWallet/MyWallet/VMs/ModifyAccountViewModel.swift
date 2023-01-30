//
//  AddModifyViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class ModifyAccountViewModel: NSObject, ObservableObject {
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
            guard let account = try context.existingObject(with: accountId) as? AccountEntity else {
                return
            }
            
            context.delete(account)
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
    
    func modifyAccount(accountId: NSManagedObjectID, model: AccountModel, isUpdateInitial: Bool) {
        do {
            guard let account = try context.existingObject(with: accountId) as? AccountEntity else {
                return
            }
            
            if isUpdateInitial {
                account.balance += (model.initialAmount - account.initialAmount)
                account.initialAmount = model.initialAmount
            }
            else {
                account.initialAmount += (model.balance - account.balance)
                account.balance = model.balance
            }
            
            account.name = model.name
            account.imageName = model.imageName
            account.type = model.type
            
            // RGBA from Color ============
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            let isSuccess = UIColor(model.color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            if isSuccess == true {
                Logger.i("Get color successfully")
            }
            else {
                Logger.e("Unable to get color")
            }
            
            account.color!.red = red
            account.color!.green = green
            account.color!.blue = blue
            account.color!.alpha = alpha
            
            // RGBA from Color ============
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
}

extension ModifyAccountViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let accounts = controller.fetchedObjects as? [AccountEntity] else {
            return
        }
        
        self.accounts = accounts.map(AccountEntityModel.init)
    }
}
