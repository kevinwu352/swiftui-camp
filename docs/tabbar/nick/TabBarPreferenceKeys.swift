//
//  TabBarPreferenceKeys.swift
//  Design
//
//  Created by Kevin Wu on 4/3/25.
//

import SwiftUI

struct TabBarItemPreferenceKey: PreferenceKey {
    static let defaultValue: [TabItem] = []
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifer: ViewModifier {
    let tab: TabItem
    @Binding var selection: TabItem
    func body(content: Content) -> some View {
        //content
        //    .opacity(selection == tab ? 1.0 : 0.0)
        //    .preference(key: TabBarItemPreferenceKey.self, value: [tab])
        if selection == tab {
            content
                .opacity(1)
                .preference(key: TabBarItemPreferenceKey.self, value: [tab])
        } else {
            Color.clear
                .opacity(0)
                .preference(key: TabBarItemPreferenceKey.self, value: [tab])
        }
    }
}

public extension View {
    func tabBarItem(tab: TabItem, selection: Binding<TabItem>) -> some View {
        modifier(TabBarItemViewModifer(tab: tab, selection: selection))
    }
}
