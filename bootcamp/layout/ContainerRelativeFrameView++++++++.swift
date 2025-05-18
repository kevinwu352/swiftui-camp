//
//  ContainerRelativeFrameView.swift
//  bootcamp
//
//  Created by Kevin Wu on 5/18/25.
//

import SwiftUI

struct ContainerRelativeFrameView: View {
    var body: some View {
        // >>> 比 GeometryReader 和 UIScreen.main.bounds 好
        // 传哪些轴就会调用后面的团包几次，闭包会收到当前父 view 给过来的尺寸，然后自己算一个尺寸返回去
         VStack {
             Text("abc")
                 .foregroundStyle(.white)
                 .containerRelativeFrame([.horizontal]) { length, axis in
                     if axis == .vertical {
                         return length / 2
                     } else {
                         return length / 2
                     }
                 }
                 .background(.red)
         }

        // 因为有 spacing 的存在，这里的块的宽度并不是准确的 2/5 父 view 宽度
        // 当 spacing 为 0 时，界面才会显示 2.5 个块
        // 注意两个 spacing 要设置一样，否则感觉会有点怪
        // ScrollView(.horizontal, showsIndicators: false) {
        //     HStack(spacing: 10) {
        //         ForEach(0..<10) { i in
        //             Text("Item \(i)")
        //                 .foregroundStyle(.white)
        //                 .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 10)
        //                 .background(.blue)
        //         }
        //     }
        // }

        // 我认为：子视图不要强求精确的尺寸，保持一个宽高比就行了
        // ScrollView(.horizontal) {
        //     LazyHStack(spacing: 10.0) {
        //         ForEach(0..<10) { item in
        //             Rectangle()
        //                 .fill(.purple)
        //                 .aspectRatio(3.0 / 2.0, contentMode: .fit)
        //                 .containerRelativeFrame(
        //                     .horizontal, count: 4, span: 3, spacing: 10.0)
        //         }
        //     }
        // }
    }
}

#Preview {
    ContainerRelativeFrameView()
}
