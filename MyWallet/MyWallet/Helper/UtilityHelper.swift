//
//  UtilityHelper.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

class UtilityHelper {
    static let shared = UtilityHelper()
    
    private init() {
    }
    
    func totalBalance(account: FetchedResults<AccountEntity>) -> String {
        var result: Double = 0.0
        
        for item in account {
            result += item.balance
        }
        
        let resultString = "\(Double(round(100 * result) / 100))"
        
        return resultString
    }
    
    func getBalanceString(balance: Double) -> String {
        return "\(Double(round(100 * balance) / 100))"
    }
    
    func getDateTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func getDateOnly(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        
        return dateFormatter.string(from: date)
    }
    
    func getTimeOnly(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    func initilizeCategory() {
        let categories = Categories.mainList
        let subcategories = Categories.subList

        for category in categories {
            let subList = subcategories.filter{ $0.parentType == category.type }
            var subDict = [String: String]()
            
            for sub in subList {
                subDict[sub.name] = sub.image
            }
            
            DataController.shared.addInitCategory(name: category.name, imageName: category.image, color: category.color, subCatDict: subDict)
        }
    }
}


