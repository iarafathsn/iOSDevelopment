//
//  Account.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct AccountModel: Identifiable {
    let id = UUID()
    let name: String
    let balance: Double
    let initialAmount: Double
    let type: String
    let imageName: String
    let color: Color
}

struct AccountType: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct AccountTypes {
    static let items = [
        AccountType(name: "General", imageName: "menucard"),
        AccountType(name: "Cash", imageName: "bag.circle"),
        AccountType(name: "Credit Card", imageName: "creditcard"),
        AccountType(name: "Savings Account", imageName: "banknote"),
        AccountType(name: "Current Account", imageName: "dollarsign.circle"),
        AccountType(name: "Others", imageName: "creditcard.trianglebadge.exclamationmark")
    ]
}
