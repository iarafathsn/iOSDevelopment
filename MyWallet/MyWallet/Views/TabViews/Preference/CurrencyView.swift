//
//  CurrencyView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct CurrencyView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var currencyVM: CurrencyViewModel
    @EnvironmentObject var currencySetting: CurrencySetting
    
    init(vm: CurrencyViewModel) {
        self.currencyVM = vm
    }

    var body: some View {
        Form {
            Picker("Code", selection: $currencyVM.currencyIndex) {
                ForEach(0 ..< currencyVM.currencyList.count, id: \.self) {
                    Text(currencyVM.currencyList[$0].code).tag($0)
                }
            }
            
            HStack {
                Text("Symbol")
                Spacer()
                Text("\(currencyVM.getCurrencyByIndex().symbol)")
            }
        }
        .onDisappear {
            currencyVM.storeCurrencyByIndex()
            currencySetting.currency = currencyVM.getCurrencyByIndex().code
        }
        .font(.title)
        .navigationTitle("Currency")
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(vm: CurrencyViewModel())
    }
}
