
import SwiftUI


@globalActor
actor TheActor {
    static var shared = TheActor()
}

class MyClass {
    var name = ""
    init(name: String = "") {
        self.name = name
    }
    func doit() {
    }
}

final class MySend: Sendable {
    let name: String
    init(name: String = "") {
        self.name = name
    }
    func doit() {
    }
}

actor MyActor {
    var name = ""
    init(name: String = "") {
        self.name = name
    }
    func doit() {
    }
}

func job(operation: @Sendable () async -> Void) { }



actor Receiver {
    let sink = Receiver()

    func isoed(_ obj: MyClass) {
        Task {
            // Sending 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and local actor-isolated uses
            // await sink.isoed(obj) // 只要后面不用，就能传走。*** 但是 task 外部后面用了不影响，有点怪 ***

            // Sending 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and local actor-isolated uses
            // await sink.isoed_async(obj) // 只要后面不用，就能传走。*** 但是 task 外部后面用了不影响，有点怪 ***

            await sink.nonisoed_async(obj)
            print(obj) // 单独打印这行不行，必须与上一行一起，呃
        }
        sink.nonisoed(obj)
        print(obj)
    }
    nonisolated func nonisoed(_ obj: MyClass) {
        Task {
            // Sending task-isolated 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and task-isolated uses
            // await sink.isoed(obj)

            // Sending task-isolated 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and task-isolated uses
            // await sink.isoed_async(obj)

            // Passing closure as a 'sending' parameter risks causing data races between code in the current task and concurrent execution of the closure
            // await sink.nonisoed_async(obj) // 这错和上两俩不一样
        }
        sink.nonisoed(obj)
        print(obj)
    }

    func isoed_async(_ obj: MyClass) async { // obj 属于 self
        // Sending 'self'-isolated 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and 'self'-isolated uses
        // await sink.isoed(obj)

        // Sending 'self'-isolated 'obj' to actor-isolated instance method 'isoed_aa' risks causing data races between actor-isolated and 'self'-isolated uses
        // await sink.isoed_async(obj)

        sink.nonisoed(obj)

        // Sending 'self'-isolated 'obj' to nonisolated instance method 'nonisoed_aa' risks causing data races between nonisolated and 'self'-isolated uses
        // await sink.nonisoed_async(obj) // *** 仔细想想这里为何失败 ***
    }
    nonisolated func nonisoed_async(_ obj: MyClass) async { // *** obj 属于 task 是什么鬼？ ***
        // Sending task-isolated 'obj' to actor-isolated instance method 'isoed_a' risks causing data races between actor-isolated and task-isolated uses
        // await sink.isoed(obj)

        // Sending task-isolated 'obj' to actor-isolated instance method 'isoed_aa' risks causing data races between actor-isolated and task-isolated uses
        // await sink.isoed_async(obj)

        sink.nonisoed(obj)

        await sink.nonisoed_async(obj) // *** 仔细想想这里为何成功 ***
    }
}



struct ContentView: View {

    let mc = MyClass(name: "")
    let ms = MySend(name: "")
    let ma = MyActor(name: "")
    func member() {
        Task {
            print(mc) // 这块区域属于 MainActor，mc 没出去
            print(ms)
            print(ma)
        }

        job {
            // await print(mc) // 报错，mc 不能离开 MainActor 且需要 await。（主要原因是 mc 不可发送，倒不是因为要出到哪个 isolation 去）
            print(ms)
            print(ma)
        }

        Task { @TheActor in
            // await print(mc) // 报错，mc 不能离开 MainActor 且需要 await
            print(ms)
            print(ma)
        }

        Task.detached { // Passing value of non-Sendable type '() async -> ()' as a 'sending' argument risks causing races in between local and caller code
            // await print(mc) // 报错，mc 不能离开 MainActor 且需要 await
            print(ms)
            print(ma)
        }
    }


    func local() {
        let mcc = MyClass(name: "")
        let mss = MySend(name: "")
        let maa = MyActor(name: "")

        Task {
            print(mcc) // 这块区域属于 MainActor，mcc 也没到哪去
            print(mss)
            print(maa)
        }

        job {
            // print(mcc) // 报错，job 需要 sendable closure，mcc 不符合。（这里也不是 mcc 要出到哪个 isolation 去）
            print(mss)
            print(maa)
        }

        let mcc1 = MyClass(name: "")
        print(mcc1)
        Task { @TheActor in
            // 'mcc' is captured by a global actor 'TheActor'-isolated closure. global actor 'TheActor'-isolated uses in closure may race against later nonisolated uses
            print(mcc1) // task 的 closure 是 sending 类型，只要后面不用 mcc，这里就可以通过。后面的 Task 内部也不能用，前面用了不影响
            print(mss)
            print(maa)
        }
        // print(mcc1)

        let mcc2 = MyClass(name: "")
        Task.detached { // Passing value of non-Sendable type '() async -> ()' as a 'sending' argument risks causing races in between local and caller code
            print(mcc2) // task 的 closure 是 sending 类型，只要后面不用 mcc，这里就可以通过
            print(mss)
            print(maa)
        }
        // print(mcc2)
    }


    func para1(_ obj: MyClass) {
        // Class 'MyClass' does not conform to the 'Sendable' protocol
        // job { print(obj) }

        Task { print(obj) }

        // Main actor-isolated 'obj' is captured by a global actor 'TheActor'-isolated closure. global actor 'TheActor'-isolated uses in closure may race against later nonisolated uses
        // Task { @TheActor in print(obj) }

        // Passing closure as a 'sending' parameter risks causing data races between main actor-isolated code and concurrent execution of the closure
        // Task.detached { print(obj) }
    }
    func para2(_ obj: MySend) {
        job { print(obj) }
        Task { print(obj) }
        Task { @TheActor in print(obj) }
        Task.detached { print(obj) }
    }
    func para3(_ obj: MyActor) {
        job { print(obj) }
        Task { print(obj) }
        Task { @TheActor in print(obj) }
        Task.detached { print(obj) }
    }


    var body: some View {
        Text("+++")
    }
}
