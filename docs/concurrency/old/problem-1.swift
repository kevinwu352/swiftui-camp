
class User {
    var name = "kv"
}
actor MyStore {
    func doit1(_ val: User) async {
        print(val.name)
        //let bb = MyStore()
        //await bb.doit2(val) // 这里凭什么又不让传了？
    }
    func doit2(_ val: User) async {
        print(val.name)
    }

    let user = User()
    func doit3() async {
        let bb = MyStore()

        // await bb.doit2(user) // 这里传不过去，user 是成员

        let u = User()
        await bb.doit2(u) // 这里能传过去，u 是新建的

        // 所以 u 归属于哪个岛？
        // 与 MainActor 上的 user 类似，难道新建的东西不属于建它那个岛？属于传到的其它岛？
    }
}
.onAppear {
    Task {
        // user 非 sendable
        let user = User()
        // MainActor 上的 user 凭什么能传给 MyStore？就算 User 有非 NSObject 父类也能传
        let aa = MyStore()
        await aa.doit1(user)
    }
}



@MainActor
class Book { // 一个主隔离的类
    var name = "kk"
}
class Cook {
    func doit() async {
        let bk = Book()
        print(await bk.name) // 在无隔离的环境下，调用但等待
        Task {
            print(await bk.name) // 在无隔离的环境下，调用但等待
        }
        Task { @MainActor in
            print(bk.name) // 在无隔离的环境下，丢到主上调用
        }
    }
}
actor MyStore {
    func doit() async {
        let bk = Book()
        print(await bk.name) // 在有隔离的环境调用
    }
}



struct ActView: View {
    let user = User()
    var body: some View {
        ZStack { }
        .onAppear {
            let u = User()
            runLater {
                print(u.name) // 编译错误
                print(user.name) // 编译错误
            }
        }
    }
    func runLater(_ function: @escaping @Sendable () -> Void) -> Void {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.0, execute: function)
    }
}



// This is nonisolated
final class MyNonIsolatedViewModel {
    weak var viewController: MyViewController?
    func start() {
        // compilation error: Call to main actor-isolated method 'displayData()' in a synchronous nonisolated context
        viewController?.displayData() // 这里编译出错
    }
}

// This is explicitly isolated to the MainActor
@MainActor
final class MyIsolatedViewModel {
    weak var viewController: MyViewController?
    func start() {
        // compiles just fine, because we don't cross isolation domains
        viewController?.displayData()
    }
}

// This inherits MainActor isolation from UIViewController
final class MyViewController: UIViewController {

    let isolatedViewModel = MyIsolatedViewModel()
    let nonIsolatedViewModel = MyNonIsolatedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        isolatedViewModel.viewController = self
        isolatedViewModel.start()

        nonIsolatedViewModel.viewController = self
        nonIsolatedViewModel.start()


        // 把上面方法改成异步的，然后这里新建变量再调用，能成功。用成员变量就是不行
        let noniso = MyNonIsolatedViewModel()
        noniso.viewController = self
        Task {
            await noniso.start2()
        }
    }

    // This is also isolated to the main actor
    func displayData() {}
}
