//
//  TabBox.swift
//  Design
//
//  Created by Kevin Wu on 4/3/25.
//

import SwiftUI

public struct TabBox<Content: View>: View {

    @Binding var hidden: Bool
    @Binding var selection: TabItem
    let content: Content
    @State var tabs: [TabItem] = []

    public init(hidden: Binding<Bool>, selection: Binding<TabItem>, @ViewBuilder content: () -> Content) {
        self._hidden = hidden
        self._selection = selection
        self.content = content()
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                content
            }
            TabBarView(tabs: tabs, selection: $selection)
                .opacity(hidden ? 0 : 1.0)
        }
//        VStack(spacing: 0) {
//            ZStack {
//                content
//            }
////            if !tabBarHidden {
////                TabBarView(tabs: tabs, selection: $selection)
////            }
//            TabBarView(tabs: tabs, selection: $selection)
//                .opacity(hidden ? 0 : 1.0)
//        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

#Preview {
    TabBox(hidden: .constant(false), selection: .constant(.home)) {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("body")
                Spacer()
                Text("foot")
            }
        }
        .tabBarItem(tab: .home, selection: .constant(.home))
        ZStack {
            Color.green.ignoresSafeArea()
            VStack {
                Text("body")
                Spacer()
                Text("foot")
            }
        }
        .tabBarItem(tab: .favorites, selection: .constant(.home))
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Text("body")
                Spacer()
                Text("foot")
            }
        }
        .tabBarItem(tab: .profile, selection: .constant(.home))
    }
}
