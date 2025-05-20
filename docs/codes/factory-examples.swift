
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


