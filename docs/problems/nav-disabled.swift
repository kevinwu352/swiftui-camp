//
//  LoginView.swift
//  HKEx
//
//  Created by Kevin Wu on 4/2/25.
//

import SwiftUI
import Design


struct RootView: View {

    @EnvironmentObject var vm: RootViewModel

    let tabs: [TabItem] = [.home, .favorites, .profile]
    @State var selection: TabItem = .home

    var body: some View {
        switch vm.scene {
        case .splash:
            SplashView()
        case .login:
            NavStack {
                WraperView {
                    LoginView()
                } tabbar: {
                    TabBarView(tabs: tabs, selection: $selection)
                }
            }
        case .main:
            MainView()
        }
    }
}


struct WraperView<Content: View, TabBar: View>: View {

    let content: Content
    let tabbar: TabBar

    init(@ViewBuilder content: () -> Content, @ViewBuilder tabbar: () -> TabBar) {
        self.content = content()
        self.tabbar = tabbar()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
            tabbar
            Text("god")
                .font(.largeTitle)
                .padding(.bottom, 49)
        }
    }
}

struct LoginView: View {
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            VStack {
                Text("login")
                Spacer()
                Text("foot")
            }
        }
//        .navBarHidden(true)
        .navBarTitle("LOGIN")
        .navBarBackable(false)
        .navBarTrailView(
            NavigationLink(value: 1) {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .padding(.trailing)
            }
        )
        .navDestination(data: Int.self) { val in
            RegisterView()
        }
    }
}

#Preview {
    NavStack {
        LoginView()
    }
}

struct TabBarView: View {

    let tabs: [TabItem]
    @Binding var selection: TabItem

    init(tabs: [TabItem], selection: Binding<TabItem>) {
        self.tabs = tabs
        self._selection = selection
    }

    var body: some View {
//        HStack { // 加上这俩够，nav 的一堆配置就失效了
            ForEach(tabs, id: \.self) { tab in
                Text("he:\(tab)")
            }
//        }
    }
}


public enum TabItem: Hashable, Sendable {
    case home
    case favorites
    case profile

    var icon: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }

    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorites: return Color.green
        case .profile: return Color.blue
        }
    }
}
