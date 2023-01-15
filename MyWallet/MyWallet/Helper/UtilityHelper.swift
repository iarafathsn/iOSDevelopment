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
    
    func getColorFromDBColor(account: Account) -> Color {
        return Color(red: account.colorRed, green: account.colorGreen, blue: account.colorBlue, opacity: account.colorAlpha)
    }
    
    func totalBalance(accounts: [Account]) -> String {
        var result: Double = 0.0
        
        for item in accounts {
            result += item.balance
        }
        
        let resultString = "\(Double(round(100 * result) / 100))"
        
        return resultString
    }
}


