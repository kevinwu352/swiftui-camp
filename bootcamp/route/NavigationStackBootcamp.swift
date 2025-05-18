//
//  NavigationStackBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 5/16/23.
//

import SwiftUI

struct NavigationStackBootcamp: View {

    let fruits = ["Apple", "Orange", "Banana"]

    @State private var paths: [String] = []

    var body: some View {
        // ios 16
        // 如果给 path 传值，会固定路径类型，Int 就跳不过去了
        NavigationStack(path: $paths) {
            ScrollView {
                VStack(spacing: 40) {
//                    Button("Super segue!") {
//                        paths.append(contentsOf: [
//                            "Coconut", "Watermelon", "Mango"
//                        ])
//                    }

                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }

                    ForEach(0..<10) { x in
                        NavigationLink(value: x) {
                            Text("Click me: \(x)")
                        }
                    }
                }
            }
            .navigationTitle("Nav Bootcamp")
            .navigationDestination(for: String.self) { value in
                Text("ANOTHER SCREEN: \(value)")
            }
            .navigationDestination(for: Int.self) { value in
                MySecondScreen(value: value)
            }
        }
    }
}

struct MySecondScreen: View {
    let value: Int
    init(value: Int) {
        self.value = value
        print("INIT SCREEN: \(value)")
    }
    var body: some View {
        Text("Screen \(value)")
    }
}

struct NavigationStackBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootcamp()
    }
}
