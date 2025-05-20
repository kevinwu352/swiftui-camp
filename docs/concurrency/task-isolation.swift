
import SwiftUI

@globalActor
actor MyActor {
    static var shared = MyActor()
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("+++")
        }
        .onAppear {
            Task {
                MainActor.assertIsolated() // 通过
            }
            Task.detached {
                MainActor.assertIsolated() // 失败
            }
            Task {
                MyActor.assertIsolated() // 失败
            }
            Task.detached {
                MyActor.assertIsolated() // 失败
            }
            Task { @MyActor in
                MyActor.assertIsolated() // 通过
            }
            Task.detached { @MyActor in
                MyActor.assertIsolated() // 通过
            }
        }
    }
}
