//
//  BootcampApp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/14/21.
//

import SwiftUI

@MainActor
public var kKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
}

@MainActor
public let kScreenW = Double(UIScreen.main.bounds.width)
@MainActor
public let kScreenH = Double(UIScreen.main.bounds.height)

@MainActor
public let kSafeTop = Double(kKeyWindow?.safeAreaInsets.top ?? 0.0)
@MainActor
public let kSafeBot = Double(kKeyWindow?.safeAreaInsets.bottom ?? 0.0)

@MainActor
public let kStatusBarH = kSafeBot > 0 ? kSafeTop : 20.0
public let kNavBarH = 44.0
public let kTabBarH = 49.0

@MainActor
public let kTopH = kStatusBarH + kNavBarH
@MainActor
public let kBotH = kSafeBot + kTabBarH

@main
struct BootcampApp: App {
//    init() {
//        // 单独设置某页面
//        //.toolbarBackgroundVisibility(.visible, for: .navigationBar) // ios18，设置导航条背景色，如果是 .visible，则大小状态下背景色都可见
//        //.toolbarBackground(Color.purple, for: .navigationBar)
//
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
//        navBarAppearance.backgroundEffect = .none
//        navBarAppearance.backgroundColor = .green
//        navBarAppearance.shadowColor = .clear
//
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        UINavigationBar.appearance().compactAppearance = navBarAppearance
//        UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance
//    }
    var body: some Scene {
        WindowGroup {
            NavigationStackBootcamp()
        }
    }
}
