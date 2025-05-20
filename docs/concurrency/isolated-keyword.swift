actor BankAccount {
    let accountNumber: Int
    var balance: Double
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
    }
}
// isolated 关键字能把 deposit 函数归属为自己，所以函数内部能访问修改 BankAccount 内部的值
func deposit(amount: Double, to account: isolated BankAccount) {
    assert(amount >= 0)
    account.balance = account.balance + amount
}






@globalActor
actor MyActor {
    static let shared = MyActor()
}


@MainActor
class User {
    // 一个被全局 actor 修饰的类型如果不写自定义的 init，那么它能在任何 actor 环境内被初始化
    // 如果写了自定义的 init，这个 init 也限定了环境，就算它不需要参数，也不能在其它 actor 上被初始化了
    // 试一下？把 run 里的 User() 放开，编译会失败。如果把这里的 init 注释了，就能成功
    init(name: String = "") {
        self.name = name
    }
    var name = "kv"
}

@MyActor
class Person {
    init(name: String) {
        self.name = name
    }
    var name = "kv"
}

// 这里的 @isolated(any) 表示：调用的时候在 in 前面传的哪个 actor，就在哪个 actor 上面运行这个 closure
func isolated_closure(_ h: @escaping @Sendable @isolated(any) () -> Void) { }

func run() {
    isolated_closure { @MyActor in
        // let user = User()
        // print(user)
        // user.name = "aa"

        let per = Person(name: "")
        print(per)
        per.name = "bb"
    }
}
