//
//  MainView.swift
//  TabNav
//
//  Created by Kevin Wu on 4/12/25.
//

import SwiftUI

public class Router: ObservableObject {
    init() {
        print("router init")
    }
    @Published public var path = NavigationPath()
}

struct MainView: View {
    init() {
        print("main init")
    }
    @StateObject var rt = Router()
    var body: some View {
        TabView {
            NavigationStack(path: $rt.path) {
                RootView()
                // work fine
//                    .navigationDestination(for: Int.self) { val in
//                        let _ = print("des called")
//                        SubView(val: val)
//                    }
                // push twice
                    .navDestination(for: Int.self) { val in
                        let _ = print("des called")
                        SubView(val: val)
                    }
            }
        }
    }
}

struct RootView: View {
    init() {
        print("root init")
    }
    var body: some View {
        VStack {
            Text("root")
            NavigationLink("sub", value: 1)
        }
        // work fine
//        .navDestination(for: Int.self) { val in
//            let _ = print("des called")
//            SubView(val: val)
//        }
    }
}

struct SubView: View {
    let val: Int
    init(val: Int) {
        self.val = val
        print("sub init")
    }
    var body: some View {
        Text("val: \(val)")
    }
}

extension View {
    func navDestination<D: Hashable, C: View>(for data: D.Type, @ViewBuilder destination: @escaping (D) -> C) -> some View {
        navigationDestination(for: data) { val in
            destination(val)
        }
    }
}


#Preview {
    MainView()
}





//struct OneSub1View: View {
//    let val: Int
//    init(val: Int) {
//        self.val = val
//        print("one sub1 init")
//    }
//    var body: some View {
//        VStack {
//            Text("val-1: \(val)")
//            NavigationLink("sub", value: "god")
//        }
//        .navigationDestination(for: String.self) { val in
//            OneSub2View(val: val)
//        }
//    }
//}
//struct OneSub2View: View {
//    let val: String
//    init(val: String) {
//        self.val = val
//        print("one sub2 init")
//    }
//    var body: some View {
//        VStack {
//            Text("val-2: \(val)")
//            NavigationLink("sub", value: 2.1234)
//        }
//        .navigationDestination(for: Double.self) { val in
//            OneSub3View(val: val)
//        }
//    }
//}
//struct OneSub3View: View {
//    let val: Double
//    init(val: Double) {
//        self.val = val
//        print("one sub3 init")
//    }
//    var body: some View {
//        Text("val-3: \(val)")
//    }
//}
