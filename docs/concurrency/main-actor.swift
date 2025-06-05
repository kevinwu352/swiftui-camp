
import Foundation

// 顶层环境是在主线程的
print("111")
MainActor.assertIsolated()
print("222")

// Task 继承了父的，所以也在主线程
// ***如果后面不 sleep 一会，这里面不会执行***
Task {
   print("333")
   MainActor.assertIsolated()
   print("444")
}
try await Task.sleep(for: .seconds(1))

// 但注意这里，不在主线程
// Task 会继承父的，但是这里是方法，方法没继承父的
func couldBeAnywhere() async {
    // MainActor.assertIsolated() // 不在主线程
    let result = await MainActor.run {
        print("This is on the main actor.")
        return 42
    }
    // MainActor.assertIsolated() // 不在主线程
    print(result)
}
await couldBeAnywhere()



// 如果不需要返回值，可以丢到一个 task 上去做，然后不等结果
func couldBeAnywhere1() {
    Task {
        await MainActor.run {
            print("This is on the main actor.")
        }
    }
    // more work you want to do
}
func couldBeAnywhere2() {
    Task { @MainActor in
        print("This is on the main actor.")
    }
    // more work you want to do
}



// 如果当前正在主线程
//   await MainActor.run() 是马上执行
//   Task { @MainActor in } 是等下个 runloop
@MainActor @Observable
class ViewModel {
    func runTest() async {
        print("1")

        await MainActor.run {
            print("2")

            Task { @MainActor in
                print("3")
            }

            print("4")
        }

        print("5")
    }
}
// 1 2 4 5 3
let model = ViewModel()
await model.runTest()
try await Task.sleep(for: .seconds(0.1))


// It's not the callsite that decides where a function runs. It's the function itself.
// 这应该说的是一个异步函数，它在哪执行，靠的是它自己的声明，而不是调用它的场景
// 同步函数肯定是在当前环境下执行

// 如果我明确说明我要在主，才会在主上执行我
// @MainActor
func downloadData() async {
    print("333")
    // 虽然调用我的地方在主，但我没说我要在哪
    // 所以 swift 自己决定在哪执行我，swift 选择了在非主执行我，而且，非常有可能选择非主
    MainActor.assertIsolated()
    print("444")
}
func couldBeAnywhere3() {
    print("111")
    Task { @MainActor in
        await downloadData()
    }
    print("222")
}
couldBeAnywhere3()
try await Task.sleep(for: .seconds(0.1))



// 所以，终极奥义
// Task 的 closure 一定在主上执行，但 closure 里面的异步代码可能会切换到其它上执行
Task { @MainActor in
    print("This will be on the main actor")
    await downloadData() // 这里面可能切换到其它线程
    print("This will also ben on the main actor")
}

// 异步函数自己决定自己在哪运行，而不是调用它的地方决定




// actor hopping
// 非主任务运行在一个协作线程池，在这里面切换性能开销比较小
// 但如果在主和线程池间切换，开销比较大
// 下面的例子中：DataModel 在主，database 不在，所以会切换 100 次
// 据说这样性能会有问题
// 解决方案是：切换一次，把 100 传给它，让它内部做 100 次
@Observable @MainActor
class DataModel {
    var users = [User]()
    var database = Database()
    func loadUsers() async {
        for i in 1...100 {
            let user = await database.loadUser(id: i)
            users.append(user)
        }
    }
}
