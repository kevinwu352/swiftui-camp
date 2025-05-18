//
//  AnyLayoutBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 9/18/23.
//

import SwiftUI

// https://useyourloaf.com/blog/size-classes/

struct AnyLayoutBootcamp: View {

    // >>> AnyLayout 用于切换布局方式，且能保留子视图状态
    // 用 if else 方式的话，原来的子视图会销毁，另一个分支的再新建

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        VStack(spacing: 12) {
            Text("Horizontal: \(horizontalSizeClass.debugDescription)")
            Text("Vertical: \(verticalSizeClass.debugDescription)")
            
            let layout: AnyLayout = horizontalSizeClass == .compact ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
            
            layout {
                Text("Alpha")
                Text("Beta")
                Text("Gamma")
            }
            
//            if horizontalSizeClass == .compact {
//                VStack {
//                    Text("Alpha")
//                    Text("Beta")
//                    Text("Gamma")
//                }
//            } else {
//                HStack {
//                    Text("Alpha")
//                    Text("Beta")
//                    Text("Gamma")
//                }
//            }
        }
    }
}

struct AnyLayoutBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyLayoutBootcamp()
    }
}
