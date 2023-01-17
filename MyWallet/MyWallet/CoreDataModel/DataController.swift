//
//  Persistence.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import CoreData
import SwiftUI

struct DataController {
    static let shared = DataController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyWallet")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
                Logger.s("Failed to load the data \(error.localizedDescription)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Save
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            Logger.i("Data saved !!!")
        } catch {
            Logger.e("We could not save the data..")
        }
    }
    
    // MARK: - Account
    func addAccount(accountModel: AccountModel, context: NSManagedObjectContext) {
        let account = Account(context: context)
        account.id = UUID()
        
        Logger.i("Saving data for Account \(accountModel.name)")
        
        self.addOrModify(account: account, accountModel: accountModel, context: context)
    }
    
    func editAccount(account: Account, accountModel: AccountModel, context: NSManagedObjectContext) {
        Logger.i("Updating data for Account \(accountModel.name)")
        
        self.addOrModify(account: account, accountModel: accountModel, context: context)
    }
    
    private func addOrModify(account: Account, accountModel: AccountModel, context: NSManagedObjectContext) {
        account.name = accountModel.name
        account.balance = accountModel.balance
        account.imageName = accountModel.imageName
        account.type = accountModel.type
        
        // RGBA from Color ============
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let isSuccess = UIColor(accountModel.color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if isSuccess == true {
            Logger.i("Get color successfully")
        }
        else {
            Logger.e("Unable to get color")
        }
        
        // RGBA from Color ============
        
        account.colorRed = red
        account.colorGreen = green
        account.colorBlue = blue
        account.colorAlpha = alpha
        
        save(context: context)
    }
    
    // MARK: - Transaction
    func addTransaction(transactionModel: TransactionModel, context: NSManagedObjectContext) {
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        
        Logger.i("Saving data for Account Name: \(transactionModel.accountName)")
        
        
        
        save(context: context)
    }
}


