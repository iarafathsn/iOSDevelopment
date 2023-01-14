//
//  SettingItem.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

enum SettingType: String, CaseIterable {
    case Profile
    case Account
    case Currency
    case Categories
    case Privacy
    case Help
    case About
}

struct SettingItem: Identifiable {
    let id = UUID()
    let name: String
    let type: SettingType
    let imageName: String
    let color: Color
}

struct SettingItemList {
    static let items = [
        SettingItem(name: SettingType.Profile.rawValue, type: .Profile, imageName: "person", color: .red),
        SettingItem(name: SettingType.Account.rawValue, type: .Account, imageName: "creditcard.trianglebadge.exclamationmark", color: .green),
        SettingItem(name: SettingType.Currency.rawValue, type: .Currency, imageName: "dollarsign.arrow.circlepath", color: .purple),
        SettingItem(name: SettingType.Categories.rawValue, type: .Categories, imageName: "plus.rectangle.on.folder", color: .brown),
        SettingItem(name: SettingType.Privacy.rawValue, type: .Privacy, imageName: "shield", color: .indigo),
        SettingItem(name: SettingType.Help.rawValue, type: .Help, imageName: "hand.raised", color: .mint),
        SettingItem(name: SettingType.About.rawValue, type: .About, imageName: "circle.hexagonpath.fill", color: .cyan)
    ]
}
