//
//  DashboardView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct DashboardView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var account: FetchedResults<AccountEntity>
    
    @State private var currency = UserDefaultHelper.shared.getCurrency().code
    
    private var dashboardVM: DashboardViewModel
    
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
                        
                        Text("\(currency) \(UtilityHelper.shared.totalBalance(account: account))")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Section {
                    List(account) { item in
                        NavigationLink(destination: AccountRecordList(account: item)) {
                            DAccountCell(account: item)
                        }
                    }
                }
            }
            .onAppear {
                Logger.i("Appearing Dashboard view")
                currency = UserDefaultHelper.shared.getCurrency().code
                UtilityHelper.shared.setDefaultDate()
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
