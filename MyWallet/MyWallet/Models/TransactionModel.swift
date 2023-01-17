//
//  TransactionModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 16/1/23.
//

import SwiftUI

struct TransactionModel: Identifiable {
    let id = UUID()
    let accountName: String
    let amount: Double
    let type: String
    let category: String
    let date: Date
    let note: String
    let payee: String
    let paymentType: String
    let toAccount: String
}
