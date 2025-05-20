//
//  MainView.swift
//  HKEx
//
//  Created by Kevin Wu on 4/2/25.
//

import SwiftUI
import Design

struct MainView: View {

    @State var hidden = false
    @State var selection: TabItem = .home

    var body: some View {
        TabBox(hidden: $hidden, selection: $selection) {
            HomeView()
                .tabBarItem(tab: .home, selection: $selection)

            FavoritesView(hidden: $hidden)
                .tabBarItem(tab: .favorites, selection: $selection)

            NavStack {
                ProfileView(hidden: $hidden)
            }
            .tabBarItem(tab: .profile, selection: $selection)

//            NavStack {
//                HomeView()
//            }
//            .tabBarItem(tab: .home, selection: $selection)
//
//            NavStack {
//                FavoritesView(hidden: $hidden)
//            }
//            .tabBarItem(tab: .favorites, selection: $selection)
//
//            NavStack {
//                ProfileView()
//            }
//            .tabBarItem(tab: .profile, selection: $selection)
        }
    }
}

#Preview {
    MainView()
}
