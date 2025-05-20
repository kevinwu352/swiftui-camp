//
//  TheView.swift
//  TestLife
//
//  Created by Kevin Wu on 5/7/25.
//

import SwiftUI

// NavigationView / NavigationStack
// 一开始就创建所有的 DetailView，但 DetailView 显示的时候才会创建 ViewModel
// NavigationView 进 Detail 再出来，ViewModel 不会销毁；NavigationStack 则会马上销毁 ViewModel

// 一定要用 NavigationStack，不要用 NavigationView

struct MainView: View {
    var body: some View {
        NavigationView {
            List(0..<10, id: \.self) { index in
                NavigationLink {
                    DetailView()
                } label: {
                    Text("\(index)")
                }
            }
        }
//        NavigationStack {
//            List(0..<10, id: \.self) { index in
//                NavigationLink(value: index) {
//                    Text("\(index)")
//                }
//            }
//            .navigationDestination(for: Int.self) { val in
//                DetailView()
//            }
//        }
    }
}

struct DetailView: View {
    @StateObject var viewModel = ViewModel()
    init() {
        print("detail init")
    }
    var body: some View {
        Text("detail \(self.viewModel.objectId)")
    }
}
class ViewModel: ObservableObject {
    var objectId: String {
        ObjectIdentifier(self).debugDescription
    }
    init() {
        print("-> ViewModel init")
    }
    deinit {
        print("-> ViewModel deinit")
    }
}
