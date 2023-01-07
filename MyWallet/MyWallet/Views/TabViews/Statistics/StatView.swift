//
//  StatView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct StatView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(.green)
            Text("Statistic View")
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold))
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}
