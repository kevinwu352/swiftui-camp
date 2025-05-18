//
//  AnimationUpdatedBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 5/18/23.
//

import SwiftUI

// >>> 动画能加到 binding 上面，.animation() 里面也能加具体动画类型
// Toggle("Toggle label", isOn: $showingWelcome.animation())

// withAnimation 还能加具体的动画类型
// withAnimation {
//     opacity = 0.2
// }
// withAnimation(.linear(duration: 2.0)) {
//     opacity = 0.2
// }
// 这种动画让所有因 opacity 改变导致的变化都动画
// 相比传统的，A 给 B 让位置，没给 A 赋动画，给 B 赋了动画，那只有 B 能动
// withAnimation 是全部动

// 前面是改属性，还能直接返回新视图，ios 17
// .animation(.easeInOut(duration: 1)) { content in
//     content
//         .background(isEnabled ? .green : .red)
// }
// .animation(.easeInOut(duration: 2)) { content in
//     content
//         .clipShape(.rect(cornerRadius: isEnabled ? 100 : 0))
// }

// Button("Press Me") {
//     isEnabled.toggle()
// }
// .foregroundStyle(.white)
// .frame(width: 200, height: 200)
// .background(isEnabled ? .green : .red)
// .animation(nil, value: isEnabled) // 颜色没动画
// .clipShape(RoundedRectangle(cornerRadius: isEnabled ? 100 : 0))
// .animation(.default, value: isEnabled) // 重新开启动画

struct AnimationUpdatedBootcamp: View {
    
    @State private var animate1: Bool = false
    @State private var animate2: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Button("Action 1") {
                    animate1.toggle()
                }
                Button("Action 2") {
                    animate2.toggle()
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: animate1 ? .leading : .trailing)
                        .background(Color.green)
                        .frame(maxHeight: .infinity, alignment: animate2 ? .top : .bottom)
                        .background(Color.orange)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                
            }
        }
        .animation(.spring().repeatForever(autoreverses: true), value: animate1)
        .animation(.linear(duration: 5), value: animate2)
        
        // deprecated!
//        .animation(.spring())
    }
}

struct AnimationUpdatedBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationUpdatedBootcamp()
    }
}
