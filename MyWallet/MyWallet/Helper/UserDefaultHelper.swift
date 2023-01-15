//
//  UserDefaultHelper.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    static let CURRENCY_KEY: String = "Currency"
    
    let mUserDefault = UserDefaults.standard
    
    private var currency: Currency = CurrencyList.items[0]
    
    private init() {
        if let currentCurrency = mUserDefault.string(forKey: UserDefaultHelper.CURRENCY_KEY) {
            if let index = CurrencyList.items.firstIndex(where: { $0.code == currentCurrency}) {
                Logger.i("Index found at \(index)")
                currency = CurrencyList.items[index]
            }
        }
        else {
            Logger.w("Default value will be set, data wasn't saved previously")
        }
    }
    
    func getCurrency() -> Currency {
        return currency
    }
    
    func setCurrency(currency: Currency) {
        mUserDefault.setValue(currency.code, forKey: UserDefaultHelper.CURRENCY_KEY)
        
        self.currency = currency
        
        Logger.i("Saving data \(currency.code) which symbol \(currency.symbol)")
    }
}
