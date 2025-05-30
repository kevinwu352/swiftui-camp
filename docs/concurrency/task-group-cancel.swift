//
//  main.swift
//  cli
//
//  Created by Kevin Wu on 5/29/25.
//

import Foundation
import QuartzCore

// TaskGroup 三种情况会取消：
// 父任务取消了
// 自己上面调用 cancelAll()
// 某个子任务异常了



// 虽然马上取消，但这三任务可能已经开始执行，他们的执行顺序是不确定的
// 最重要的是：任务内部要自己检查是否取消
// cancelAll 只取消还在的任务，已完成的影响不了
// 1) 如果三个任务内部不自己检查是否取消，那么根本不会走到 catch，会按正常流程走完
// 2) 如果第三个任务检查了，第一二任务可能先执行，且把值写入了 collected，而第三个任务检测到取消，所以走到 catch，最后打印出一二的值
//    一二三的执行顺序是不一定的，所以，有可能三比一二先执行，这样的话，collected 就是空的，反正不要预先假设它们的执行顺序
func printMessage() async {
    let result = await withThrowingTaskGroup(of: String.self) { group in
        group.addTask { "Testing" }
        group.addTask { "Group" }
        group.addTask {
            // try Task.checkCancellation()
            return "Cancellation"
        }
        group.cancelAll()

        var collected = [String]()
        do {
            for try await value in group {
                collected.append(value)
            }
        } catch {
            print(error.localizedDescription)
        }
        return collected.joined(separator: " ")
    }
    print(result)
}
//await printMessage()


// 1) 先抛异常，用 waitForAll
//   waitForAll 是等所有任务完成，某子任务先抛出异常，还是会等下去，不会马上结束
//   其它子任务会正常结束，且 isCancelled 为 false，也就是先抛的异常根本没取消这个子任务
//   我觉得是因为没有调 group.next() 获取值，如果获取值会获得子任务抛出的那个异常，并马上抛出，继而取消另外一个任务
//   等待完成后，外层的 do catch 会收到子任务最开始抛出的异常
//   牢记：try await group.waitForAll() 并不会抛出子任务发出的异常
// 2) 先抛异常，用 next 读取值。。。马上就取消了
//   调用 next，先读到的值是抛出的异常，所以继续往外抛，然后 do catch 收到异常就取消 group
//   此时任务二还在 sleep，sleep 内部会检测是否 cancel，所以它马上不睡了，且抛出异常，后续的打印代码也不会执行了
// 3) 后抛异常，用 waitForAll
//   比较简单，任务二正常结束，任务一再抛异常
//   do catch 收到异常
// 4) 后抛异常，用 next 读取值
//   任务二正常结束，且用 next 获取到了值，值是 ()
//   再获取值，得到异常，do catch 收到异常
// 5) 后抛异常，用 next 读取值，但只读一次
//   读到了任务二的值
//   group 会等任务一结束，>>>> 但 do catch 收不到异常 <<<
enum ExampleError: Error {
    case badURL
}
func testCancellation() async {
    print("begin")
    let time = CACurrentMediaTime()
    do {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await Task.sleep(for: .seconds(5))
                throw ExampleError.badURL
            }

            group.addTask {
                try await Task.sleep(for: .seconds(1))
                print("Task is cancelled: \(Task.isCancelled), \(CACurrentMediaTime() - time)")
            }

             try await group.waitForAll()
//            let aa = try await group.next()
//            print("aa: \(aa)")
//            let bb = try await group.next()
//            print("bb: \(bb)")
//            let cc = try await group.next()
//            print("cc: \(cc)")
        }
    } catch {
        print("Error thrown: \(error.localizedDescription), \(CACurrentMediaTime() - time)")
    }
    print("end")
}
await testCancellation()
