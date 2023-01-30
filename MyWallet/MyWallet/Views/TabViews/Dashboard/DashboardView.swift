//
//  DashboardView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var currencySetting: CurrencySetting
    
    @ObservedObject var dashboardVM: DashboardViewModel
    
    init(vm: DashboardViewModel) {
        self.dashboardVM = vm
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Balance")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(currencySetting.currency) \(dashboardVM.totalBalance)")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Section {
                    ForEach(dashboardVM.accounts) { item in
                        NavigationLink(destination: AccountRecordList(account: item)) {
                            HStack {
                                CellImageView(imageName: item.imageName, color: item.color)
                                
                                VStack {
                                    Text("\(item.name)")
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(currencySetting.currency) \(item.balanceString)")
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataModel.shared.container.viewContext
        DashboardView(vm: DashboardViewModel(context: viewContext))
    }
}
