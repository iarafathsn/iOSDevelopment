//
//  Currency.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

struct Currency: Identifiable {
    let id = UUID()
    let symbol: String
    let code: String
}

struct CurrencyList {
    static let items = [
        Currency(symbol: "$", code: "USD"),
        Currency(symbol: "₽", code: "RUB"),
        Currency(symbol: "؋", code: "AFN"),
        Currency(symbol: "€", code: "EUR"),
        Currency(symbol: "Lek", code: "ALL"),
        Currency(symbol: "£", code: "GBP"),
        Currency(symbol: "دج", code: "DZD"),
        Currency(symbol: "Kz", code: "AOA"),
        Currency(symbol: "$", code: "XCD"),
        Currency(symbol: "$", code: "ARS"),
        Currency(symbol: "֏", code: "AMD"),
        Currency(symbol: "ƒ", code: "AWG"),
        Currency(symbol: "£", code: "SHP"),
        Currency(symbol: "$", code: "AUD"),
        Currency(symbol: "₼", code: "AZN"),
        Currency(symbol: "$", code: "BSD"),
        Currency(symbol: "BD", code: "BHD"),
        Currency(symbol: "৳", code: "BDT"),
        Currency(symbol: "$", code: "BBD"),
        Currency(symbol: "BYN", code: "BYN"),
        Currency(symbol: "$", code: "BZD"),
        Currency(symbol: "Fr", code: "XOF"),
        Currency(symbol: "$", code: "BMD"),
        Currency(symbol: "Nu", code: "BTN"),
        Currency(symbol: "Bs", code: "BOB"),
        Currency(symbol: "KM", code: "BAM"),
        Currency(symbol: "P", code: "BWP"),
        Currency(symbol: "R$", code: "BRL"),
        Currency(symbol: "$", code: "BND"),
        Currency(symbol: "$", code: "SGD"),
        Currency(symbol: "Lev", code: "BGN"),
        Currency(symbol: "Fr", code: "BIF"),
        Currency(symbol: "CR", code: "KHR"),
        Currency(symbol: "Fr", code: "XAF"),
        Currency(symbol: "$", code: "CAD"),
        Currency(symbol: "$", code: "CVE"),
        Currency(symbol: "$", code: "KYD"),
        Currency(symbol: "$", code: "CLP"),
        Currency(symbol: "¥", code: "CNY"),
        Currency(symbol: "$", code: "COP"),
        Currency(symbol: "Fr", code: "KMF"),
        Currency(symbol: "Fr", code: "CDF"),
        Currency(symbol: "$", code: "NZD"),
        Currency(symbol: "₡", code: "CRC"),
        Currency(symbol: "$", code: "CUP"),
        Currency(symbol: "ƒ", code: "ANG"),
        Currency(symbol: "Kč", code: "CZK"),
        Currency(symbol: "kr", code: "DKK"),
        Currency(symbol: "Fr", code: "DJF"),
        Currency(symbol: "$", code: "DOP"),
        Currency(symbol: "LE", code: "EGP"),
        Currency(symbol: "Nkf", code: "ERN"),
        Currency(symbol: "L", code: "SZL"),
        Currency(symbol: "R", code: "ZAR"),
        Currency(symbol: "Br", code: "ETB"),
        Currency(symbol: "£", code: "FKP"),
        Currency(symbol: "$", code: "FJD"),
        Currency(symbol: "Fr", code: "XPF"),
        Currency(symbol: "D", code: "GMD"),
        Currency(symbol: "₾", code: "GEL"),
        Currency(symbol: "₵", code: "GHS"),
        Currency(symbol: "£", code: "GIP"),
        Currency(symbol: "Q", code: "GTQ"),
        Currency(symbol: "Fr", code: "GNF"),
        Currency(symbol: "$", code: "GYD"),
        Currency(symbol: "G", code: "HTG"),
        Currency(symbol: "L", code: "HNL"),
        Currency(symbol: "$", code: "HKD"),
        Currency(symbol: "Ft", code: "HUF"),
        Currency(symbol: "kr", code: "ISK"),
        Currency(symbol: "₹", code: "INR"),
        Currency(symbol: "Rp", code: "IDR"),
        Currency(symbol: "Rl", code: "IRR"),
        Currency(symbol: "ID", code: "IQD"),
        Currency(symbol: "₪", code: "ILS"),
        Currency(symbol: "$", code: "JMD"),
        Currency(symbol: "¥", code: "JPY"),
        Currency(symbol: "JD", code: "JOD"),
        Currency(symbol: "₸", code: "KZT"),
        Currency(symbol: "Sh", code: "KES"),
        Currency(symbol: "₩", code: "KPW"),
        Currency(symbol: "₩", code: "KRW"),
        Currency(symbol: "KD", code: "KWD"),
        Currency(symbol: "som", code: "KGS"),
        Currency(symbol: "₭", code: "LAK"),
        Currency(symbol: "LL", code: "LBP"),
        Currency(symbol: "L", code: "LSL"),
        Currency(symbol: "$", code: "LRD"),
        Currency(symbol: "LD", code: "LYD"),
        Currency(symbol: "Fr", code: "CHF"),
        Currency(symbol: "MOP$", code: "MOP"),
        Currency(symbol: "Ar", code: "MGA"),
        Currency(symbol: "K", code: "MWK"),
        Currency(symbol: "RM", code: "MYR"),
        Currency(symbol: "Rf", code: "MVR"),
        Currency(symbol: "UM", code: "MRU"),
        Currency(symbol: "Re", code: "MUR"),
        Currency(symbol: "$", code: "MXN"),
        Currency(symbol: "Leu", code: "MDL"),
        Currency(symbol: "₮", code: "MNT"),
        Currency(symbol: "DH", code: "MAD"),
        Currency(symbol: "Mt", code: "MZN"),
        Currency(symbol: "K", code: "MMK"),
        Currency(symbol: "$", code: "NAD"),
        Currency(symbol: "Re", code: "NPR"),
        Currency(symbol: "C$", code: "NIO"),
        Currency(symbol: "₦", code: "NGN"),
        Currency(symbol: "DEN", code: "MKD"),
        Currency(symbol: "₺", code: "TRY"),
        Currency(symbol: "kr", code: "NOK"),
        Currency(symbol: "RO", code: "OMR"),
        Currency(symbol: "₨", code: "PKR"),
        Currency(symbol: "B/", code: "PAB"),
        Currency(symbol: "K", code: "PGK"),
        Currency(symbol: "₲", code: "PYG"),
        Currency(symbol: "S/", code: "PEN"),
        Currency(symbol: "₱", code: "PHP"),
        Currency(symbol: "zł", code: "PLN"),
        Currency(symbol: "QR", code: "QAR"),
        Currency(symbol: "Leu", code: "RON"),
        Currency(symbol: "Fr", code: "RWF"),
        Currency(symbol: "DA", code: "DZD"),
        Currency(symbol: "$", code: "WST"),
        Currency(symbol: "Db", code: "STN"),
        Currency(symbol: "SR", code: "SAR"),
        Currency(symbol: "DIN", code: "RSD"),
        Currency(symbol: "SR", code: "SCR"),
        Currency(symbol: "Le", code: "SLE"),
        Currency(symbol: "$", code: "SBD"),
        Currency(symbol: "Sh", code: "SOS"),
        Currency(symbol: "Re", code: "LKR"),
        Currency(symbol: "LS", code: "SDG"),
        Currency(symbol: "$", code: "SRD"),
        Currency(symbol: "kr", code: "SEK"),
        Currency(symbol: "LS", code: "SYP"),
        Currency(symbol: "$", code: "TWD"),
        Currency(symbol: "SM", code: "TJS"),
        Currency(symbol: "Sh", code: "TZS"),
        Currency(symbol: "฿", code: "THB"),
        Currency(symbol: "T$", code: "TOP"),
        Currency(symbol: "$", code: "TTD"),
        Currency(symbol: "DT", code: "TND"),
        Currency(symbol: "m", code: "TMT"),
        Currency(symbol: "Sh", code: "UGX"),
        Currency(symbol: "₴", code: "UAH"),
        Currency(symbol: "د.إ", code: "AED"),
        Currency(symbol: "$", code: "UYU"),
        Currency(symbol: "soum", code: "UZS"),
        Currency(symbol: "VT", code: "VUV"),
        Currency(symbol: "Bs.S", code: "VES"),
        Currency(symbol: "Bs.D", code: "VED"),
        Currency(symbol: "₫", code: "VND"),
        Currency(symbol: "﷼", code: "YER"),
        Currency(symbol: "K", code: "ZMW"),
        Currency(symbol: "Z$", code: "ZWL")
    ]
}