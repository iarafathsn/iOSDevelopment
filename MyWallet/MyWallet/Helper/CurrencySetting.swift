//
//  CurrencySetting.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation

@MainActor
class CurrencySetting: ObservableObject {
    @Published var currency: String = CurrencyList.items[0].code
    
    static let shared = CurrencySetting()
    
    private init() {
        if let currentCurrency = UserDefaults.standard.string(forKey: "Currency") {
            if let index = CurrencyList.items.firstIndex(where: { $0.code == currentCurrency}) {
                Logger.i("Index found at \(index)")
                
                currency = CurrencyList.items[index].code
            }
        }
        else {
            Logger.w("Default value will be set, data wasn't saved previously")
        }
    }
}
