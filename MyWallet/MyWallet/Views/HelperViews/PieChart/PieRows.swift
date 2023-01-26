//
//  PieRows.swift
//  MyWallet
//
//  Created by Arafat Hossain on 25/1/23.
//

import SwiftUI

struct PieRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    
    var body: some View {
        VStack {
            List(0..<self.values.count, id:\.self) { index in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[index])
                        .frame(width: 20, height: 20)
                    
                    Text(self.names[index])
                    
                    Spacer()
                    
                    Text(self.values[index])
                        .frame(alignment: .trailing)
                }
            }
            .listStyle(.plain)
        }
        .padding(10)
    }
}

struct PieRows_Previews: PreviewProvider {
    static var previews: some View {
        PieRows(colors: [.red, .blue, .green], names: ["Transport", "Housing", "Utility"], values: ["50.0", "30.0", "20.0"])
    }
}
