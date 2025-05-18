//
//  MultipleSheetsBootcamp.swift
//  continued
//
//  Created by Nick Sarno on 3/27/21.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// >>> .sheet 并未在视图加载过程中调用

// 1)
// 当用户点击按钮时，sheet 调用，创建 NextScreen，但是 NextScreen 收到的 model 不是最新的
// 当用户再次点击时，sheet 调用，创建 NextScreen，并且 NextScreen 使用了最新正确的 model

// 2)
// 如果用户只点某一项，那永远都显示 0
// 第一次点 5，第二次换一个点，就正常了

// 解决方案
// 1 - use a binding
// 虽然能成功，但是 BindScreen 第一次创建的时候 init 得到的值不对
// 2 - use multiple .sheets
// 以前貌似同一个树不能有两个 .sheet，所以，当 VStack 和它的子视图 都有 .sheet 时，里面那个不起作用。
// 现在好像不是了，两个都能起作用。而且，同一个结点两个 .sheet 也行
// 3 - use $item
// 完美解决方案

struct MultipleSheetsBootcamp: View {

    @State var model = RandomModel(title: "--")
    @State var shown = false
    @State var index = 0

//    @State var shown1 = false
//    @State var shown2 = false

    @State var item: RandomModel?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { i in
                    Button("Button \(i)") {
                        // 1)
                        // model = RandomModel(title: "\(i)")
                        // shown.toggle()
                        // 2)
                        // index = i
                        // shown.toggle()

                        item = RandomModel(title: "\(i)")
                    }
                }

//                Button("AAA") {
//                    shown1.toggle()
//                }
//                Button("BBB") {
//                    shown2.toggle()
//                }
            }
            // 1)
            // .sheet(isPresented: $shown) {
            //     let _ = print("sheet")
            //     NextScreen(model: model)
            // }
            // 2)
            // .sheet(isPresented: $shown) {
            //     let _ = print("sheet")
            //     NextScreen(model: RandomModel(title: "\(index)"))
            // }

            // .sheet(isPresented: $shown) {
            //     let _ = print("sheet")
            //     BindScreen(model: $model)
            // }

//            .sheet(isPresented: $shown1) {
//                NextScreen(model: .init(title: "111"))
//            }
//            .sheet(isPresented: $shown2) {
//                NextScreen(model: .init(title: "222"))
//            }

            .sheet(item: $item) { it in
                NextScreen(model: it)
            }
        }
    }
}

struct NextScreen: View {
    let model: RandomModel
    init(model: RandomModel) {
        self.model = model
        print("init \(model.title)")
    }
    var body: some View {
        Text(model.title)
            .font(.largeTitle)
    }
}

struct BindScreen: View {
    @Binding var model: RandomModel
    init(model: Binding<RandomModel>) {
        _model = model
        print("init \(model.wrappedValue.title)")
    }
    var body: some View {
        Text(model.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
