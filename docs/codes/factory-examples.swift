
singleton
graph
unique / shared / cached


如何取出

@Injected(\.network) private var net1

private let net2 = Container.shared.network()

// 把 Container 传进去，但不存
class ContentViewModel: ObservableObject {
    let service2: MyServiceType
    init(container: Container) {
        service2 = container.service()
    }
}
// 把 Container 传进去，存起来，并且懒加载
class ContentViewModel: ObservableObject {
    private let container: Container
    private lazy var service: MyConstructedService = container.constructedService()
    init(container: Container) {
        self.container = container
    }
}


如何注入，写类 与 配置

extension Container {
    var network: Factory<Networkable> {
        self { HTTPClient() }.shared
        //Factory(self) { HTTPClient() }
    }
}
protocol Networkable {
    func req()
}
class HTTPClient: Networkable {
    init() {
        print("client init")
    }
    deinit { print("client deinit") }
    func req() {
        print("client req \(dev_obj_addr(self))")
    }
}


带参数

// let gen = Container.shared.generator("k")
//protocol StrGenerating {
//}
extension Container {
    var generator: ParameterFactory<String, StrGenerator> {
        self { StrGenerator(pref: $0) }
    }
}
class StrGenerator {
    let pref: String
    init(pref: String) {
        self.pref = pref
    }
    var val = 0
    func next() -> String {
        val += 1
        return "\(pref)\(val)"
    }
}


如果 A 依赖 B，貌似两种获取 B 的方式没什么区别
extension Container {
    var switcher1: Factory<LoginSwitching> {
        self { LoginSwitcher(keychain: self.keychain()) }.cached
    }
}
class Switcher {
    let kyc: Keychain
    init(keychain: Keychain) {
        kyc = keychain
    }
}
extension Container {
    var switcher2: Factory<LoginSwitching> {
        self { LoginSwitcher() }.cached
    }
}
class Switcher {
    let kyc = Container.shared.keychain()
    init() {
        print("switcher init")
    }
}


如果 A 依赖 B，A resolve 以后，再 register 新的 B
    如果获取 A，A 是旧的，且用的旧 B
    如果获取 B 则会创建新 B

如果 A 依赖 B，A resolve 以后，再 register 新的 A
    如果获取 A，会创建新的
    如果获取 B，还是旧的



reset 功能
reset 可以重置已经生成的对象，也就是清空 cache。也可以清空注册的东西

Container.shared.router.reset() 这行代码，如果 router 有注册 Container.shared.router.register { @MainActor in Router() } ，会清空它，而用最原始声明时候的代码，如下
public extension Container {
    @MainActor
    var router: Factory<Router> {
        self { @MainActor in Router() }
    }
}
也就是，如果原始文件中可能用的是占位的类 UserManagerPh，登录成功后用 UserManager，那么在它上面清空注册，再清空缓存，再获取对象，获取到的是 Ph


Container.shared.manager.reset(options: .registration)
这是清空所有的注册，但是已经获取的对象不会销毁，它们还存在内部缓存中
Container.shared.manager.reset(options: .scope)
再调用清空所有的域，这时候才会清空已获取的对象，下次再获取就是新的
Container.shared.manager.reset()
这会清空全部，注册和已获取的，还有其它的东西


Container.shared.router.reset()
这是清除具体的某个的全部
Container.shared.manage.reset(.registration)
Container.shared.manage.reset(.scope)
这俩也是一样，一个清除注册，一个清除缓存
