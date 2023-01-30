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
            CurrencyView(vm: CurrencyViewModel())
        case .Categories:
            CategoryList(vm: CategoryListViewModel(context: CoreDataModel.shared.container.viewContext))
        case .Account:
            AccountListView(vm: AccountListViewModel(context: CoreDataModel.shared.container.viewContext))
        case .About :
            AboutView()
        default:
            Text("Default view")
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack {
            Text("\(UtilityHelper.shared.getAppDisplayName()) is an app to make life easier.")
            Text("Current Version: \(UtilityHelper.shared.getAppVersion())")
            Spacer()
            Text("Developed by Md. Arafat Hossain")
                .font(.headline)
                .foregroundColor(.green)
            Spacer()
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .center)
        .navigationTitle("About")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
