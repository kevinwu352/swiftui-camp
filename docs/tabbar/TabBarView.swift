//
//  TabBarView.swift
//  HKEx
//
//  Created by Kevin Wu on 4/4/25.
//

import SwiftUI

let TAB_BAR_HET = 49.0

enum TabBarItem: Hashable, CaseIterable {
    case home
    case market
    case wallet

    var icon: String {
        switch self {
        case .home: return "house"
        case .market: return "chart.bar"
        case .wallet: return "wallet.bifold"
        }
    }

    var title: String {
        switch self {
        case .home: return NSLocalizedString("tab_home", comment: "")
        case .market: return NSLocalizedString("tab_market", comment: "")
        case .wallet: return NSLocalizedString("tab_wallet", comment: "")
        }
    }

    var color: Color {
        switch self {
        case .home: return Color.red
        case .market: return Color.green
        case .wallet: return Color.blue
        }
    }
}

struct TabBarView: View {

    @Binding var selection: TabBarItem
    @State var locsel: TabBarItem
    @Namespace var animation

    init(selection: Binding<TabBarItem>) {
        self._selection = selection
        self.locsel = selection.wrappedValue
    }

    var body: some View {
        HStack {
            ForEach(TabBarItem.allCases, id: \.self) { tab in
                VStack {
                    Image(systemName: tab.icon)
                        .font(.subheadline)
                    Text(tab.title)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                }
                .frame(height: TAB_BAR_HET)
                .frame(maxWidth: .infinity)
                .foregroundColor(locsel == tab ? tab.color : Color.gray)
                //.background(locsel == tab ? tab.color.opacity(0.2) : Color.clear)
                //.cornerRadius(10)
                .background(
                    ZStack {
                        if locsel == tab {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(tab.color.opacity(0.2))
                                .matchedGeometryEffect(id: "background_rectangle", in: animation)
                        }
                    }
                )
                .onTapGesture {
                    selection = tab
                }
                .onChange(of: selection) {
                    withAnimation(.easeInOut) {
                        locsel = selection
                    }
                }
            }
        }
        .frame(height: TAB_BAR_HET)
        .background(Color.tabbarBg)
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.red.ignoresSafeArea()
        TabBarView(selection: .constant(.home))
    }
}
