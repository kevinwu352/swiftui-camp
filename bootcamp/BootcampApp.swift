//
//  BootcampApp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/14/21.
//

import SwiftUI

@main
struct BootcampApp: App {
    init() {
        // 单独设置某页面
        //.toolbarBackgroundVisibility(.visible, for: .navigationBar) // ios18，设置导航条背景色，如果是 .visible，则大小状态下背景色都可见
        //.toolbarBackground(Color.purple, for: .navigationBar)

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.backgroundColor = .green
        navBarAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance
    }
    var body: some Scene {
        WindowGroup {
            NavigationStackBootcamp()
        }
    }
}
