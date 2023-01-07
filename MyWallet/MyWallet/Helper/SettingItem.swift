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
}

struct SettingItemList {
    static let items = [
        SettingItem(name: SettingType.Profile.rawValue, type: .Profile, imageName: "person"),
        SettingItem(name: SettingType.Account.rawValue, type: .Account, imageName: "creditcard.trianglebadge.exclamationmark"),
        SettingItem(name: SettingType.Currency.rawValue, type: .Currency, imageName: "dollarsign.arrow.circlepath"),
        SettingItem(name: SettingType.Categories.rawValue, type: .Categories, imageName: "questionmark.folder"),
        SettingItem(name: SettingType.Privacy.rawValue, type: .Privacy, imageName: "shield"),
        SettingItem(name: SettingType.Help.rawValue, type: .Help, imageName: "questionmark"),
        SettingItem(name: SettingType.About.rawValue, type: .About, imageName: "drop.triangle")
    ]
}
