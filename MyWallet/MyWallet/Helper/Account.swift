//
//  Account.swift
//  MyWallet
//
//  Created by Arafat Hossain on 14/1/23.
//

import SwiftUI

struct Account: Identifiable {
    let id = UUID()
    let name: String
    let balance: Float
    let type: String
    let color: Color
    let image: String
}
