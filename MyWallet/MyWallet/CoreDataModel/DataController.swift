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
        let account = AccountEntity(context: context)
        account.id = UUID()
        account.balance = accountModel.balance
        
        Logger.i("Saving data for Account \(accountModel.name)")
        
        let colorEntity = ColorEntity(context: context)
        colorEntity.id = UUID()
        
        self.addOrModify(account: account, accountModel: accountModel, colorEntity: colorEntity, context: context)
    }
    
    func editAccount(account: AccountEntity, accountModel: AccountModel, context: NSManagedObjectContext) {
        Logger.i("Updating data for Account \(accountModel.name)")
        
        Logger.d("Initial amount: \(account.initialAmount) update value: \(accountModel.balance) currentBalance: \(account.balance)")
        
        account.balance += (accountModel.balance - account.initialAmount)
        
        Logger.d("Updated current balance: \(account.balance)")
        
        self.addOrModify(account: account, accountModel: accountModel, colorEntity: account.color!, context: context)
    }
    
    
    private func addOrModify(account: AccountEntity, accountModel: AccountModel, colorEntity: ColorEntity, context: NSManagedObjectContext) {
        account.name = accountModel.name
        account.initialAmount = accountModel.balance
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
        colorEntity.red = red
        colorEntity.green = green
        colorEntity.blue = blue
        colorEntity.alpha = alpha
        
        account.color = colorEntity
        
        save(context: context)
    }
    
    // MARK: - Transaction
    func addTransaction(transactionModel: TransactionModel, context: NSManagedObjectContext) {
        let transaction = TransactionEntity(context: context)
        transaction.id = UUID()
        
        Logger.i("Saving data for Account Name: \(transactionModel.account.name!)")
        
        if transactionModel.type == AddType.transfer.rawValue {
            transactionModel.account.balance -= transactionModel.amount
            transactionModel.toAccount?.balance += transactionModel.amount
            
            transaction.toAccount = transactionModel.toAccount
        }
        else if transactionModel.type == AddType.income.rawValue {
            transactionModel.account.balance += transactionModel.amount
            transaction.subCategory = transactionModel.subcategory
        }
        else {
            transactionModel.account.balance -= transactionModel.amount
            transaction.subCategory = transactionModel.subcategory
        }
        
        transaction.fromAccount = transactionModel.account
        transaction.amount = transactionModel.amount
        transaction.type = transactionModel.type
        transaction.paymentType = transactionModel.paymentType
        transaction.note = transactionModel.note
        transaction.payee = transactionModel.payee
        transaction.date = transactionModel.date
        
        save(context: context)
    }
    
    // MARK: - Relationship Model
    func addInitCategory(name: String, imageName: String, color: Color, subCatDict: [String: String]) {
        let category = CategoryEntity(context: self.container.viewContext)
        category.id = UUID()
        category.name = name
        category.imageName = imageName
        
        // RGBA from Color ============
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let isSuccess = UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if isSuccess == true {
            Logger.i("Get color successfully")
        }
        else {
            Logger.e("Unable to get color")
        }
        
        // RGBA from Color ============
        
        let colorEntry = ColorEntity(context: self.container.viewContext)
        colorEntry.id = UUID()
        colorEntry.red = red
        colorEntry.green = green
        colorEntry.blue = blue
        colorEntry.alpha = alpha
        
        category.color = colorEntry
        
        var subCategories: [SubCategoryEntity] = [SubCategoryEntity]()
        
        for subKey in subCatDict {
            let subCatEntity = SubCategoryEntity(context: self.container.viewContext)
            subCatEntity.id = UUID()
            subCatEntity.name = subKey.key
            subCatEntity.imageName = subKey.value
            
//            subCatEntity.category = category
            
            subCategories.append(subCatEntity)
        }
        
        category.subCategories = NSSet(array: subCategories)
        
        self.save(context: self.container.viewContext)
    }
}


