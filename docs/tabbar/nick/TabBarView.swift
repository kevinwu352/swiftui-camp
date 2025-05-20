//
//  TabBarView.swift
//  Design
//
//  Created by Kevin Wu on 4/3/25.
//

import SwiftUI

public let TAB_BAR_HET = 49.0

struct TabBarView: View {

    let tabs: [TabItem]
    @Binding var selection: TabItem
    @State var selloc: TabItem

    init(tabs: [TabItem], selection: Binding<TabItem>) {
        self.tabs = tabs
        self._selection = selection
        selloc = selection.wrappedValue
    }

    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack {
                    Image(systemName: tab.icon)
                        .font(.subheadline)
                    Text(tab.title)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                }
                .frame(height: TAB_BAR_HET)
                .frame(maxWidth: .infinity)
                .foregroundColor(selloc == tab ? tab.color : Color.gray)
                .background(selloc == tab ? tab.color.opacity(0.2) : Color.clear)
                .cornerRadius(10)
                //.background(
                //    ZStack {
                //        if selloc == tab {
                //            RoundedRectangle(cornerRadius: 10)
                //                .fill(tab.color.opacity(0.2))
                //                .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                //        }
                //    }
                //)
                .onTapGesture {
                    selection = tab
                }
                .onChange(of: selection) {
                    withAnimation(.easeInOut) {
                        selloc = selection
                    }
                }
            }
        }
        .frame(height: TAB_BAR_HET)
        .background(Color("tabbar/background", bundle: .module))
    }
}

#Preview {
    VStack(spacing: 0) {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("body")
                Spacer()
                Text("foot")
            }
        }
        TabBarView(tabs: [.home, .favorites, .profile],
                   selection: .constant(.home)
        )
    }
}
