//
//  SettingsView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct SettingsView: View {
    var settingItems: [SettingItem] = SettingItemList.items
    
    var body: some View {
        NavigationView {
            VStack {
                List(settingItems) { item in
                    HStack(spacing: 10) {
                        NavigationLink(destination: SettingDetailView(type: item.type)) {
                            CellImageView(imageName: item.imageName, color: item.color)
                            
                            Text(item.name)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .font(.system(size: 24, weight: .semibold, design: .rounded))
        }
    }
}

struct SettingDetailView: View {
    var type: SettingType
    
    var body: some View {
        switch type {
        case .Currency:
            CurrencyView()
        case .Categories:
            CategoryList()
        case .Account:
            AccountListView()
        default:
            Text("Default view")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
