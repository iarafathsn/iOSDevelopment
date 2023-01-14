//
//  CurrencyView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct CurrencyView: View {
    @ObservedObject var defaultDataVM = DefaultDataVM()

    var body: some View {
        Form {
            Picker("Code", selection: $defaultDataVM.currencyIndex) {
                ForEach(0 ..< defaultDataVM.currencyList.count, id: \.self) {
                    Text(defaultDataVM.currencyList[$0].code).tag($0)
                }
            }
            
            HStack {
                Text("Symbol")
                Spacer()
                Text("\(defaultDataVM.setCurrency(index: defaultDataVM.currencyIndex).symbol)")
            }
        }
        .navigationTitle("Currency")
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
