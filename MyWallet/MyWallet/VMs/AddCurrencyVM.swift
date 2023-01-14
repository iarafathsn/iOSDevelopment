//
//  DefaultDataVM.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

class AddCurrencyVM: ObservableObject {
    @Published var currencyIndex: Int = 0
    
    let userDefault = UserDefaults.standard
    var currencyList = CurrencyList.items
    var currency: Currency = CurrencyList.items[0]
    
    init() {
        currencyList = currencyList.sorted { $0.code < $1.code }
        
        currency = UserDefaultHelper.shared.getCurrency()
        
        if let index = currencyList.firstIndex(where: { $0.code == currency.code}) {
            currencyIndex = index
            
            Logger.i("Index found at \(index) value: \(currency.code)")
        }
    }
    
    func setCurrency(index: Int) -> Currency {
        if index < currencyList.count {
            currency = currencyList[index]
            
            UserDefaultHelper.shared.setCurrency(currency: currency)
        }
        else {
            Logger.w("Currency could not be stored for index = \(index)")
        }
        
        return currency
    }
}
