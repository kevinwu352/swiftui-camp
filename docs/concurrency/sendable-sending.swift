
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("+++")
        }
        .onAppear {
            let mc = MyClass()

            sending_closure {
                print(mc)
            }
            // print(mc)
            // 用 sending 时，当 mc 新建了，马上传给 sending 闭包，且后面再也不用 mc，那么不会报错
            // 只要后面 print(mc) 就要报错

            // sendable_closure {
            //     print(mc)
            // }
            // 用 sendable 时，mc 是非 sendable 的，所以报错
        }
    }
}

class MyClass { }

func sending_closure(_ closure: sending () -> Void) {
    closure()
}

func sendable_closure(_ closure: @Sendable () -> Void) {
    closure()
}
