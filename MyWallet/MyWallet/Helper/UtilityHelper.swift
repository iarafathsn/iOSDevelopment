//
//  UtilityHelper.swift
//  MyWallet
//
//  Created by Arafat Hossain on 15/1/23.
//

import SwiftUI

class UtilityHelper {
    static let shared = UtilityHelper()
    
    private var previousDate: Date
    
    private init() {
        previousDate = Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date()
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
    
    func isSameDay(date: Date) -> Bool {
        let order = Calendar.current.compare(date, to: previousDate, toGranularity: .day)
        previousDate = date
        
        if order == .orderedSame {
            return true
        }
        else {
            return false
        }
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
            
            CoreDataModel.shared.addInitCategory(name: category.name, imageName: category.image, color: category.color, subCatDict: subDict)
        }
    }
    
    // MARK: - Transaction Cell Helper
    func getTransactionColor(transaction: TransactionEntity) -> Color {
        if transaction.type == AddType.transfer.rawValue {
            return ColorEMHelper.getColor(colorEntity: (transaction.toAccount?.color)!)
        }
        else {
            return ColorEMHelper.getColor(colorEntity: (transaction.subCategory?.category?.color)!)
        }
    }
    
    func getRecordColor(recordModel: RecordModel) -> Color {
        if recordModel.type == AddType.transfer.rawValue {
            return ColorEMHelper.getColor(colorEntity: (recordModel.toAccount?.color)!)
        }
        else {
            return ColorEMHelper.getColor(colorEntity: (recordModel.subCategory?.category?.color)!)
        }
    }
    
    func getTransactionTitle(transaction: TransactionEntity) -> String {
        if transaction.type == AddType.transfer.rawValue {
            return "Withdraw"
        }
        else {
            return transaction.subCategory?.wrappedName ?? "Unknown"
        }
    }
    
    func getRecordTitle(recordModel: RecordModel) -> String {
        if recordModel.type == AddType.transfer.rawValue {
            return "Withdraw"
        }
        else {
            return recordModel.subCategory?.wrappedName ?? "Unknown"
        }
    }
    
    func getRecordImageName(recordModel: RecordModel) -> String {
        if recordModel.type == AddType.transfer.rawValue {
            return "arrow.left.arrow.right"
        }
        else {
            return recordModel.subCategory?.wrappedImageName ?? "arrow.counterclockwise"
        }
    }
    
    func getImageName(transaction: TransactionEntity) -> String {
        if transaction.type == AddType.transfer.rawValue {
            return "arrow.left.arrow.right"
        }
        else {
            return transaction.subCategory?.wrappedImageName ?? "arrow.counterclockwise"
        }
    }
    
    func setDefaultDate() {
        previousDate = Calendar.current.date(byAdding: .year, value: -50, to: Date()) ?? Date()
    }
    
    func getAppDisplayName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    func getAppIcon() -> String {
        var appIconName: String! {
            guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
                  let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
                  let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
                  let lastIcon = iconFiles.last else { return nil }
            return lastIcon
        }
        
        return appIconName
    }
    
    func getAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
}


