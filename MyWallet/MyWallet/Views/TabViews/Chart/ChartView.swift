//
//  ChartView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct ChartView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(.orange)
            Text("Chart View")
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold))
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
