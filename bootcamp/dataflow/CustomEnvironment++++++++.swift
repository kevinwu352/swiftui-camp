//
//  CustomEnvironment.swift
//  bootcamp
//
//  Created by Kevin Wu on 3/23/25.
//

import SwiftUI

//class CounterViewModel: ObservableObject {
//    @Published var count = 0
//}
//
//@StateObject var vm = CounterViewModel()
//@ObservedObject var vm: CounterViewModel
//
//.environmentObject(vm)
//@EnvironmentObject var vm: CounterViewModel
//
// 把它放进 .environment(\.xxx, yyy) 再取出来，取出来的页面如果改变 count，页面不会刷新


//@Observable
//final class CounterViewModel {
//    var count = 0
//}
//
//@State var vm = CounterViewModel()
//
//@Bindable var vm: CounterViewModel
//
//.environment(vm)
//@Environment(CounterViewModel.self) var vm
//@Environment(CounterViewModel.self) var vm: CounterViewModel?
//
// 把它放进 .environment(\.xxx, yyy) 再取出来，取出来的页面如果改变 count，页面会刷新



// Key

// 新写法，用这种
@Observable
final class Theme {
    var primaryColor: String
    init(primaryColor: String) {
        self.primaryColor = primaryColor
    }
}
extension EnvironmentValues {
    @Entry var primaryTheme: Theme = .init(primaryColor: "red")
}

// 使用
//@Environment(\.primaryTheme) private var primaryTheme: Theme


// 修改值
//   .environment(\.mainPaddingValue, 101)
// 获取值，可以直接获取，只有需要修改时才调用上一句
//   @Environment(\.mainPaddingValue) var mp

struct MainPaddingKey: EnvironmentKey {
    static var defaultValue: Double = 20.0
}

extension EnvironmentValues {
    var mainPaddingValue: Double {
        get {
            self[MainPaddingKey.self]
        }
        set {
            self[MainPaddingKey.self] = newValue
        }
    }
}
