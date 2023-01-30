//
//  AddViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class AddAccountViewModel: NSObject, ObservableObject {
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addAccount(model: AccountModel) {
        do {
            let account = AccountEntity(context: context)
            account.id = UUID()
            account.name = model.name
            account.balance = model.balance
            account.initialAmount = model.balance
            account.type = model.type
            account.imageName = model.imageName
            
            let balanceString = String(format: "%.2f", model.balance)
            
            Logger.i("Saving data for Account: \(model.name) with Value: \(balanceString)")
            
            let colorEntity = ColorEntity(context: context)
            colorEntity.id = UUID()
            
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
            
            colorEntity.red = red
            colorEntity.green = green
            colorEntity.blue = blue
            colorEntity.alpha = alpha
            // RGBA from Color ============
            
            account.color = colorEntity
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
}
