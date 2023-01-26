//
//  Category.swift
//  MyWallet
//
//  Created by Arafat Hossain on 7/1/23.
//

import SwiftUI

enum CategoryType: Int {
    case Food = 1, Vehicle, Shopping, Housing, Electronics, Transportation, Healthcare, Financial, Income, Kids, Entertainment
}

struct Category: Identifiable {
    let id = UUID()
    let type: CategoryType
    let name: String
    let color: Color
    let image: String
}

struct SubCategory: Identifiable {
    let id = UUID()
    let parentType: CategoryType
    let name: String
    let image: String
}

struct Categories {
    static let mainList = [
        Category(type: .Food, name: "Food & Drinks", color: .yellow, image: "fork.knife"),
        Category(type: .Vehicle, name: "Vehicle", color: .indigo, image: "car"),
        Category(type: .Shopping, name: "Shopping", color: .orange, image: "handbag"),
        Category(type: .Housing, name: "Housing", color: .blue, image: "house"),
        Category(type: .Electronics, name: "Electronics", color: .brown, image: "macbook.and.iphone"),
        Category(type: .Transportation, name: "Transportation", color: .mint, image: "bus"),
        Category(type: .Healthcare, name: "Healthcare", color: .red, image: "cross"),
        Category(type: .Financial, name: "Financial", color: .purple, image: "dollarsign.arrow.circlepath"),
        Category(type: .Income, name: "Income", color: .cyan, image: "banknote"),
        Category(type: .Kids, name: "Kids, Parent", color: .teal, image: "figure.2.and.child.holdinghands"),
        Category(type: .Entertainment, name: "Entertainment", color: .green, image: "party.popper")
    ]
    
    static let subList = [
        SubCategory(parentType: .Food, name: "Fast food", image: "takeoutbag.and.cup.and.straw"),
        SubCategory(parentType: .Food, name: "Bar, Restaurant, Cafe", image: "wineglass"),
        SubCategory(parentType: .Food, name: "Takeout, Online", image: "fork.knife.circle"),
        SubCategory(parentType: .Vehicle, name: "Fuel", image: "fuelpump"),
        SubCategory(parentType: .Vehicle, name: "Parking", image: "parkingsign"),
        SubCategory(parentType: .Vehicle, name: "Maintenance", image: "exclamationmark.transmission"),
        SubCategory(parentType: .Vehicle, name: "Insurance", image: "abs"),
        SubCategory(parentType: .Shopping, name: "Groceries", image: "stroller.fill"),
        SubCategory(parentType: .Shopping, name: "Clothes, Shoes", image: "shoeprints.fill"),
        SubCategory(parentType: .Shopping, name: "Health, Beauty", image: "vial.viewfinder"),
        SubCategory(parentType: .Shopping, name: "Pets", image: "pawprint"),
        SubCategory(parentType: .Shopping, name: "Gift", image: "gift"),
        SubCategory(parentType: .Housing, name: "Rent", image: "lock"),
        SubCategory(parentType: .Housing, name: "Utilities", image: "lightbulb"),
        SubCategory(parentType: .Housing, name: "Garden", image: "tree"),
        SubCategory(parentType: .Housing, name: "Servant, Babysitter", image: "figure.stand.line.dotted.figure.stand"),
        SubCategory(parentType: .Housing, name: "Insurance", image: "person.text.rectangle"),
        SubCategory(parentType: .Housing, name: "Mortgage", image: "video.doorbell"),
        SubCategory(parentType: .Electronics, name: "Computer", image: "pc"),
        SubCategory(parentType: .Electronics, name: "Phone", image: "iphone.gen1"),
        SubCategory(parentType: .Electronics, name: "Call charges", image: "candybarphone"),
        SubCategory(parentType: .Electronics, name: "Internet", image: "personalhotspot"),
        SubCategory(parentType: .Electronics, name: "Software", image: "desktopcomputer.and.arrow.down"),
        SubCategory(parentType: .Transportation, name: "Public Transport", image: "tram"),
        SubCategory(parentType: .Transportation, name: "Taxi", image: "car.front.waves.up"),
        SubCategory(parentType: .Transportation, name: "Flight, Trip", image: "airplane.departure"),
        SubCategory(parentType: .Transportation, name: "Rentals", image: "figure.wave"),
        SubCategory(parentType: .Healthcare, name: "Drug", image: "pill"),
        SubCategory(parentType: .Healthcare, name: "Doctor, Clinic, Treatment", image: "cross.case"),
        SubCategory(parentType: .Healthcare, name: "Fitness", image: "heart"),
        SubCategory(parentType: .Financial, name: "Taxes", image: "list.bullet.rectangle.portrait.fill"),
        SubCategory(parentType: .Financial, name: "Charges, Fees, Interests", image: "slider.horizontal.2.square.badge.arrow.down"),
        SubCategory(parentType: .Financial, name: "Loan, Lend, Dues", image: "list.bullet"),
        SubCategory(parentType: .Financial, name: "Insurance", image: "calendar.day.timeline.right"),
        SubCategory(parentType: .Income, name: "Salary", image: "dollarsign"),
        SubCategory(parentType: .Income, name: "Interests, Dividends, Dues", image: "banknote.fill"),
        SubCategory(parentType: .Income, name: "Property, Rent", image: "homekit"),
        SubCategory(parentType: .Income, name: "Lottery, Gambling, Coupons, Games", image: "gamecontroller"),
        SubCategory(parentType: .Income, name: "Freelancing, Advisory", image: "playstation.logo"),
        SubCategory(parentType: .Income, name: "Sale, Rental", image: "cart.badge.minus"),
        SubCategory(parentType: .Kids, name: "Education", image: "text.book.closed"),
        SubCategory(parentType: .Kids, name: "Diaper, Milk, Food", image: "takeoutbag.and.cup.and.straw.fill"),
        SubCategory(parentType: .Kids, name: "Toys, Play, Entertainment", image: "teddybear"),
        SubCategory(parentType: .Kids, name: "Pocket money, Expenses", image: "list.bullet.clipboard"),
        SubCategory(parentType: .Entertainment, name: "Party, Life events, Hobbies", image: "heart.circle"),
        SubCategory(parentType: .Entertainment, name: "TV, Subscriptions", image: "tv.and.mediabox"),
        SubCategory(parentType: .Entertainment, name: "Holiday, Trips, Hotels", image: "airplane"),
        SubCategory(parentType: .Entertainment, name: "Charity, Gift", image: "giftcard")
    ]
}
