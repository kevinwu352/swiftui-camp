
actor MyActor {
    var name = ""
    func doit() async {
        let ds = DataService()
        print(ds.value)

        let hm = HTTPManager()
        //await hm.run(ds)
        Task { await hm.run(ds) } // 这里就怪了，和 MainActor 不一样
        await hm.run(ds)
    }
    func run(_ ds: DataService) {
        print(ds.value)
    }
}

@MainActor
class HTTPManager {
    var url = ""
    var headers: [String:String] = [:]
    func doit() async {
        let ds = DataService()
        print(ds.value)

        let ma = MyActor()
        //await ma.run(ds) // 放这里会编译出错，放后面不会；一个 await 不会出错，两个会；一个 await + Task 会出错
        Task { await ma.run(ds) }
        await ma.run(ds)
    }
    func run(_ ds: DataService) {
        print(ds.value)
    }
}

class DataService {
    var value = ""
    func doit() {
        //let ma = MyActor()
        //Task { print(await ma.name) }

        //let hm = HTTPManager()
        //Task { print(await hm.url) }
    }
}
