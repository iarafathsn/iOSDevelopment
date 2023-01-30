//
//  DefaultDataVM.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

class CurrencyViewModel: ObservableObject {
    @Published var currencyIndex: Int = 0
    
    private let mUserDefault = UserDefaults.standard
    
    var currencyList = CurrencyList.items

    init() {
        currencyList = currencyList.sorted { $0.code < $1.code }
        
        if let currentCurrency = mUserDefault.string(forKey: "Currency") {
            if let index = currencyList.firstIndex(where: { $0.code == currentCurrency}) {
                Logger.i("Index found at \(index)")
                
                currencyIndex = index
            }
        }
        else {
            Logger.w("Default value will be set, data wasn't saved previously")
        }
    }
    
    func getCurrencyByIndex() -> Currency {
        return currencyList[currencyIndex]
    }
    
    func storeCurrencyByIndex() {
        let currency = currencyList[currencyIndex]
        
        mUserDefault.setValue(currency.code, forKey: "Currency")
        
        Logger.i("Saving data \(currency.code) which symbol \(currency.symbol)")
    }
}
