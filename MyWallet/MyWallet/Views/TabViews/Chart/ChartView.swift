//
//  ChartView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject private var chartVM: ChartViewModel
    @EnvironmentObject var currencySetting: CurrencySetting
    
    init(vm: ChartViewModel) {
        chartVM = vm
    }
    
    var body: some View {
        if chartVM.pieItems.count == 0 {
            ZStack {
                Circle()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.orange)
                Text("No records found")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        else {
            VStack(spacing: 10) {
                PieChart(title: "Expenses", pieItems: chartVM.pieItems, formatter: {value in String(format: "\(currencySetting.currency.code) %.2f", value)})
            }
            .padding(10)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(vm: ChartViewModel(context: CoreDataModel.shared.container.viewContext))
    }
}
