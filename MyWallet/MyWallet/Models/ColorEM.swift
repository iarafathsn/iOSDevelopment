//
//  ColorEM.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//

import SwiftUI

struct ColorEM: Identifiable {
    let id = UUID()
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

class ColorEMHelper {
    static func getColor(colorEntity: ColorEntity) -> Color {
        return Color(red: colorEntity.red, green: colorEntity.green, blue: colorEntity.blue, opacity: colorEntity.alpha)
    }
}
