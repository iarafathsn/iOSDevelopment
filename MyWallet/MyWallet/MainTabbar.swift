//
//  MainTabbar.swift
//  MyWallet
//
//  Created by Arafat Hossain on 31/12/22.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case pie
    case plus
    case bar
    case gearshape
}

struct MainTabbar: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        if (selectedTab == .pie || selectedTab == .bar) {
           return "chart." + selectedTab.rawValue + ".fill"
        }
        else if selectedTab == .plus {
            return selectedTab.rawValue + ".app.fill"
        }
        else {
            return selectedTab.rawValue + ".fill"
        }
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .house:
            return .blue
        case .pie:
            return .green
        case .plus:
            return .red
        case .bar:
            return .green
        case .gearshape:
            return .orange
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: currentTabImage(tab: tab))
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
        }
    }
    
    func currentTabImage(tab: Tab) -> String {
        if tab == selectedTab {
            return fillImage
        }
        else if (tab == .pie || tab == .bar) {
            return "chart." + tab.rawValue
        }
        else if tab == .plus {
            return tab.rawValue + ".app"
        }
        else {
            return tab.rawValue
        }
    }
}

struct MainTabbar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbar(selectedTab: .constant(.house))
    }
}
