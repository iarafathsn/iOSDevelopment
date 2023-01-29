//
//  DashboardViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData

class DashboardViewModel: ObservableObject {
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        
    }
}
