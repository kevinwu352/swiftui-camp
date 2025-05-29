
// The highest priority is .high, which is synonymous with the old .userInitiated priority from Grand Central Dispatch (GCD). As the name implies, this should be used only for tasks that the user specifically started and is actively waiting for.
// Next highest is .medium, which is a great choice for most of your tasks that the user isn’t actively waiting for.
// Next is .low, which is synonymous with the old .utility priority from GCD. This is the best choice for anything long enough to require a progress bar to be displayed, such as copying files or importing data.
// The lowest priority is .background, which is for any work the user can’t see, such as building a search index. This could in theory take hours to complete.


@globalActor
actor MyActor {
    static let shared = MyActor()
}


// 异步的 getter
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
        print("222") // 上面一定会异常，但如果这里不访问 task.value，就不会走到 catch 里面，直接是：222 和 Starting
    } catch {
        print("Task was cancelled.")
    }
}
