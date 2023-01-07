//
//  AddEntryView.swift
//  MyWallet
//
//  Created by Arafat Hossain on 1/1/23.
//

import SwiftUI

struct AddEntryView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(.blue)
            Text("Add Entry View")
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold))
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
