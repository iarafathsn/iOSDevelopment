//
//  DefaultDataVM.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

class DefaultDataVM: ObservableObject {
    @Published var currencyIndex: Int = 0
    
    let userDefault = UserDefaults.standard
    let CurrencyKey = "Currency"
    var currencyList = CurrencyList.items
    var currency: Currency = CurrencyList.items[0]
    
    init() {
        currencyList = currencyList.sorted { $0.code < $1.code }
        
        if let currentCurrency = userDefault.string(forKey: CurrencyKey) {
            print("Currency \(currentCurrency)")
            
            if let index = currencyList.firstIndex(where: { $0.code == currentCurrency}) {
                print("Index found at \(index)")
                currency = currencyList[index]
                currencyIndex = index
            }
            else {
                currency = currencyList[0]
                currencyIndex = 0
            }
        }
        else {
            currency = currencyList[0]
            currencyIndex = 0
        }
    }
    
    func setCurrency(index: Int) -> Currency {
        if index < currencyList.count {
            currency = currencyList[index]
            userDefault.setValue(currency.code, forKey: CurrencyKey)
            
            print("Saving data \(currency.code) which symbol \(currency.symbol)")
        }
        else {
            print("Currency could not be stored for index = \(index)")
        }
        
        return currency
    }
}
