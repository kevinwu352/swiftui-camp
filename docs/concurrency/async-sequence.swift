
import SwiftUI

struct DoubleGenerator: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 9

        mutating func next() async -> Int? {
            defer { current -= 2 }
            // try? await Task.sleep(for: .seconds(1))
            if current <= 0 {
                return nil // 返回 nil 结束这个 Sequence
            } else {
                return current
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}
// 另一种实现
//struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
//    var current = 1
//    mutating func next() async -> Int? {
//        defer { current &*= 2 }
//        if current < 0 {
//            return nil
//        } else {
//            return current
//        }
//    }
//    func makeAsyncIterator() -> DoubleGenerator {
//        self
//    }
//}

struct ContentView: View {
    var body: some View {
        Text("Hello, world")
            .task {
                for await number in DoubleGenerator() {
                    print(number)
                }
            }
    }
}


let url = URL(string: "https://hws.dev/users.csv")!
var iterator = url.lines.makeAsyncIterator()
// 读取一个元素
if let line = try await iterator.next() {
    print("The first user is \(line)")
}
// 读取四个元素
for i in 2...5 {
    if let line = try await iterator.next() {
        print("User #\(i): \(line)")
    }
}
// 读取剩下的元素
var remainingResults = [String]()
while let result = try await iterator.next() {
    remainingResults.append(result)
}



// 将异步序列转化为正常序列
extension AsyncSequence {
    func collect() async throws -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}



// AsyncStream 对应的是 continuation
// continuation 把 completion 转化为 async 函数
// AsyncStream 把 xxx 转化为异步序列
let stream = AsyncStream { continuation in
    for i in 1...9 {
        continuation.yield(i)
    }
    continuation.finish()
}
for await item in stream {
    print(item)
}
// AsyncStream 有三种缓存策略
// 如果缓存数量是 0，如果当前没人在接收数据，马上就丢弃了
// 下面的例子是先创建 stream，再接收，一秒后再发数据
let stream = AsyncStream(bufferingPolicy: .bufferingOldest(0)) { continuation in
    Task {
        try await Task.sleep(for: .seconds(1))
        continuation.yield("Hello, AsyncStream!")
        continuation.finish()
    }
}
for await item in stream {
    print(item)
}



// 三个任务共同消化 stream 的元素，并不是每个任务内部循环 9 次
// If you need every task to receive every value, you should look at a Combine publisher instead.
let stream = AsyncStream { continuation in
    for i in 1...9 {
        continuation.yield(i)
    }
    continuation.finish()
}
Task {
    for await item in stream {
        print("1. \(item)")
    }
}
Task {
    for await item in stream {
        print("2. \(item)")
    }
}
Task {
    for await item in stream {
        print("3. \(item)")
    }
}
try? await Task.sleep(for: .seconds(1))
