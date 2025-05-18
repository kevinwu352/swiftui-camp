//
//  ScrollViewBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/20/21.
//

import SwiftUI

// >>> ScrollView 用法

// ScrollView
//   LazyVGrid
//     Section
//       ForEach
//     Section
//       ForEach
//
// ScrollView
//   LazyVStack
//     ForEach

// ScrollView 内，VStack 只占需要的宽度，但 LazyVStack 因为不知道未加载的视图有多宽，所以一开始就占所有宽度

struct ScrollViewBootcamp: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100) { index in
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack {
                            ForEach(0..<20) { index in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewBootcamp()
    }
}
