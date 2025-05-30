
// Task 优先级
// The highest priority is .high, which is synonymous with the old .userInitiated priority from Grand Central Dispatch (GCD). As the name implies, this should be used only for tasks that the user specifically started and is actively waiting for.
// Next highest is .medium, which is a great choice for most of your tasks that the user isn’t actively waiting for.
// Next is .low, which is synonymous with the old .utility priority from GCD. This is the best choice for anything long enough to require a progress bar to be displayed, such as copying files or importing data.
// The lowest priority is .background, which is for any work the user can’t see, such as building a search index. This could in theory take hours to complete.

// Task 优先级提升：
// 1)高优先级任务等待低优先级任务，低任务的优先级会提升
// 2)低优先级任务运行于某 actor，此时高优先级任务入队了，低任务的优先级会提升


// 哪些 Sendable
// All of Swift’s core value types, including Bool, Int, String, and similar.
// Optionals, where the wrapped data is a value type.
// Standard library collections that contain value types, such as Array<String> or Dictionary<Int, String>.
// Tuples where the elements are all value types.
// Metatypes, such as String.self.

// Actors automatically conform to Sendable because they handle their synchronization internally.
// Custom structs and enums you define will also automatically conform to Sendable if they contain only values that also conform to Sendable, similar to how Codable works.
// Custom classes can conform to Sendable as long as they either inherits from NSObject or from nothing at all, all properties are constant and themselves conform to Sendable, and they are marked as final to stop further inheritance.

// group 适合不定数量
// task 和 group 能显式 cancel，async let 不行
// task 创建后能存起来，async let 不行
// group 返回类型要相同，能用 enum 规避

@globalActor
actor MyActor {
    static let shared = MyActor()
}

// 异步的 getter，只能只读，加 setter 会出错
var value: Success { get async throws }
var contents: T {
    get async throws {
        // ...
    }
}


// 等待 Task 返回一个值
func doit() async {
    let task = Task {
        print("111")
        try? await Task.sleep(for: .seconds(5.0))
        print("222")
        return [1,2,3]
    }

    print("begin")
    let list = await task.value
    print(list)
    // 如果不返回值，task.value 也能访问，不过 value 的类型是 ()，也就是 Void
}


func doit() async {
    let task = Task { () -> String in
        print("Starting")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        print("111") // 不会走到这里，因为马上取消了，sleep 里面就异常退出了
        try Task.checkCancellation()
        return "Done"
    }
    task.cancel()
    do {
        // let res = await task.result // 访问 task.result 需要 await，但不用 try
        // print(res)
        // let result = try await task.value
        // print("Result: \(result)")
        // 上面一定会异常，但如果这里不访问 task.value，就不会走到 catch 里面，直接是：222 和 Starting
        // try await task.value 用于重新抛出 task 里面的异常，如果不访问则不会往外抛了
        print("222")
    } catch {
        print("Task was cancelled.")
    }
}



// task group 示例
// withDiscardingTaskGroup 是一种自动丢弃 task 的 group
func doit() async {
    //let string = await withTaskGroup(of: String.self) { group -> String in
    let string = await withTaskGroup { group in // 能推断出来，用这精简版
        group.addTask { "Hello" }
        group.addTask { "From" }
        group.addTask { "A" }
        group.addTask { "Task" }
        group.addTask { "Group" }

        var collected = [String]()
        for await value in group {
            collected.append(value)
        }
        return collected.joined(separator: " ")
    }
    print(string)
}
// async let 示例
func printUserDetails() async {
    async let username = getUser()
    async let scores = getHighScores()
    async let friends = getFriends()

    let user = await UserData(name: username, friends: friends, highScores: scores)
    print("Hello, my name is \(user.name), and I have \(user.friends.count) friends!")
}
func getFriends() async -> [String] {
    do {
        try await Task.sleep(for: .seconds(2.0))
        print("111")
        return ["Eric", "Maeve", "Otis"]
    } catch {
        print("222") // 如果上面不 await UserData()，会 cancel 掉，走到这里
        return []
    }
}
func printUserDetails() async {
    async let nums = getNums() // 这俩函数能抛出异常，但此时不 try，也不用 await
    async let ages = getAges()
    do {
        let list = try await nums + ages // 这里 try await
        print(list)
        // async let 的另一种等待的方式
        // return await (news, weather, hasUpdate)
    } catch {
        print("err")
    }
}
// 这里 user 不能发送，注意理解这个编译错误，目前我也不太懂
class User {
    let name: String
    let password: String
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}
@main
struct App {
    static func main() async {
        async let user = User(name: "twostraws", password: "fr0st1es") // 这里出错
        await print(user.name)
    }
}


// completion 和 async 方法能同名
func doit() async {
    let list = await fetchLatestNews()
    print(list)
    fetchLatestNews { ls in
        print(ls)
    }
}
func fetchLatestNews(completion: sending @escaping ([String]) -> Void) {
    DispatchQueue.main.async {
        completion(["11", "22"])
    }
}
func fetchLatestNews() async -> [String] {
    return ["aa", "bb"]
}


// CheckedContinuation<String, Never>
// UnsafeContinuation<[Int], Error>
// 有些功能的回调是通过 delegate，且两个函数，这时可以把 continuation 存下来，然后在那两个函数里面调用
// try await withCheckedThrowingContinuation { continuation in
//     locationContinuation = continuation
//     manager.requestLocation()
// }
