
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
