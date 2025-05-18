//
//  TransitionBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/25/21.
//

import SwiftUI

// >>> 合并几个 transition
// extension AnyTransition {
//     static var moveAndScale: AnyTransition {
//         AnyTransition.move(edge: .bottom).combined(with: .scale)
//     }
// }

// identity
// asymmetric
//
// opacity
// scale 从小到大，从大到小
// scale(scale: 0.9) 从 0.9-1.0，从 1.0-0.9
//
// slide 从 leading 进，从 trailing 出，没有 alpha 变化
// push(from: .leading) 从参数那个值进，另外一边出
//                       动画速度与 slide 动画相同，只是这里 alpha 0-1，再 1-0
// move(edge: .leading) 从参数那个值进，从参数这个值出。其余和 slide 一样
//
// offset ???

struct TransitionBootcamp: View {

    @State var showView: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack {
                Button("BUTTON") {
                    withAnimation(.easeInOut) { // <- animation here
                        showView.toggle()
                    }
                }
                Spacer()
            }

            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(
                        insertion: .push(from: .trailing), //.move(edge: .bottom),
                        removal: .push(from: .leading) //AnyTransition.opacity.animation(.easeInOut)
                    ))
            }


        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TransitionBootcamp()
    }
}
