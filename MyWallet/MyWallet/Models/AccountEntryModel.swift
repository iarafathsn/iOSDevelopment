//
//  AccountEntryModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 30/1/23.
//

import Foundation
import CoreData
import SwiftUI

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
    
    var balanceString: String {
        String(format: "%.2f", account.balance)
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
    
    var transactions: [RecordModel] {
        account.transactionFromArray.map(RecordModel.init)
    }
}
