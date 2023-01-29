//
//  CurrencySetting.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation

class CurrencySetting: ObservableObject {
    @Published var currency: Currency = CurrencyList.items[0]
}
