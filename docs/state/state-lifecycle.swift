
import SwiftUI

func dev_obj_addr(_ obj: AnyObject) -> String {
    String(describing: Unmanaged.passUnretained(obj).toOpaque())
}

struct ContentView: View {
    @State var val = 0
    var body: some View {
        VStack {
            Text("Hello, world!")
            Button("+++") {
                val += 1
            }
            ChildView(name: "\(val)")
            SubView(name: "\(val)")
        }
    }
}


struct ChildView: View {
    @StateObject var vm: ChildViewModel
    let name: String
    init(name: String) {
        print("child init")
        self.name = name
        _vm = StateObject(wrappedValue: ChildViewModel(nam: name)) // ***只会调用一次***
    }
    var body: some View {
        VStack {
            Text("child \(dev_obj_addr(vm))")
            Text(name)
            Text(vm.nam)
        }
        .background(Color.yellow)
    }
}
class ChildViewModel: ObservableObject {
    @Published var nam: String
    init(nam: String) {
        print("child vm init \(nam)")
        self.nam = nam
    }
    deinit {
        print("child vm deinit")
    }
}


struct SubView: View {
    let name: String
    @State var vm: SubViewModel
    init(name: String) {
        print("sub init")
        self.name = name
        _vm = .init(wrappedValue: .init(nam: name)) // ***会调用很多次，但界面上用的一直是一个***
    }
    var body: some View {
        VStack {
            Text("sub \(dev_obj_addr(vm))")
            Text(name)
            Text(vm.nam)
        }
        .background(Color.green)
    }
}
@Observable
class SubViewModel {
    var nam: String
    init(nam: String) {
        print("sub vm init \(nam)")
        self.nam = nam
    }
    deinit {
        print("sub vm deinit")
    }
}

// 无完美解决方案，这是一种
struct SubView1: View {
    var name: String
    @State var vm: SubViewModel
    init(name: String) {
        print("sub init")
        self.name = name
        _vm = .init(wrappedValue: .init(nam: name))
    }
    var body: some View {
        VStack {
            Text("sub \(dev_obj_addr(vm))")
            Text(name)
            Text(vm.nam)
        }
        .background(Color.green)
        .onChange(of: name) { // 注意这里。并非一定要在视图内部操作才会调用，当在外面重建此视图的时候 onChange 为 false 也会调用
            self.vm = .init(nam: name)
        }
    }
}



// 界面上 Group 包几个 View，View 内部包 ViewModel，当用 .id(theid) 重绘 Group 时，内部的 @StateObject/@State 也重建了
// 界面上 Group 包几个 View，View 内部包 ViewModel，View 需要当前页面一个 @State 作为参数，当此参数变化时 View 会重建，但 ViewModel 不会
// loggedOut / authenticated 这种 enum，当在两个 authenticated 之间变化时，它所渲染的 View 会重绘，但内部的 ViewModel 不会
//
// struct ChildView: View {
//     @StateObject var viewModel: ViewModel
//     let name: String
//     init(name: String) {
//         self.name = name
//         _viewModel = StateObject(wrappedValue: ViewModel(nam: name)) // ***只会调用一次***
//         print("child init")
//     }
//     var body: some View {
//         VStack {
//             Text("Child \(viewModel.objectId)")
//             Text(name)
//             Text(viewModel.nam)
//         }
//     }
// }
// ParentView 的 @State name 改变时，会重绘 ChildView 并将新值传给 ChildView 的 init 方法
// 最开始 ChildView 的 name 和 ViewModel 的 nam 相同，当 ParentView 改变一次后，两值就不同了
// ChildView 一直是最新的，ViewModel 是旧的，因为 @StateObject 只创建一次
// 但是但是：如果是 @State 则会新建一个 ViewModel，但界面上用的还是旧的，新建的这个去哪了？
