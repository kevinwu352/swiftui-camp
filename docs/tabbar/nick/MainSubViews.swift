//
//  MainSubViews.swift
//  HKEx
//
//  Created by Kevin Wu on 4/3/25.
//

import SwiftUI

struct HomeView: View {
    init() {
        print("home init")
    }
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("home")
                Spacer()
                Text("foot")
            }
        }
        .onAppear {
            print("home appear")
        }
        .onDisappear {
            print("home disappear")
        }
        .task {
            print("home task")
        }
    }
}

struct FavoritesView: View {
    @Binding var hidden: Bool
    init(hidden: Binding<Bool>) {
        self._hidden = hidden
        print("favorites init")
    }
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack {
                Text("favorites")
                Spacer()
                Button("doit") {
                    hidden.toggle()
                }
                Text("foot")
            }
        }
        .onAppear {
            print("favorites appear")
        }
        .onDisappear {
            print("favorites disappear")
        }
        .task {
            print("favorites task")
        }
    }
}

struct ProfileView: View {
    @Binding var hidden: Bool
    init(hidden: Binding<Bool>) {
        self._hidden = hidden
        print("profile init")
    }
//    init() {
//        print("profile init")
//    }
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Text("profile")
                Spacer()
                NavigationLink(value: 101) {
                    Text("sub")
                }
                .foregroundStyle(Color.red)
                Text("foot")
                Spacer()
            }
        }
        .navDestination(data: Int.self) { val in
//            let _ = hidden.toggle()
            let _ = hidden = true
            ProfileSubView(val)
        }
        .onAppear {
            hidden = false
            print("profile appear")
        }
        .onDisappear {
//            hidden = true
            print("profile disappear")
        }
        .task {
            print("profile task")
        }
    }
}

struct ProfileSubView: View {
    let val: Int
    init(_ val: Int) {
        self.val = val
        print("profile sub init")
    }
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            VStack {
                Text("profile sub: \(val)")
                Spacer()
                Text("foot")
            }
        }
        .onAppear {
            print("profile sub appear")
        }
        .onDisappear {
            print("profile sub disappear")
        }
        .task {
            print("profile sub task")
        }
    }
}

