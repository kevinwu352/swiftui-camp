//
//  ToolbarBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 5/16/23.
//

import SwiftUI

struct ToolbarBootcamp: View {

    @State private var text: String = ""
    @State private var paths: [String] = []

    var body: some View {
        NavigationStack(path: $paths) {
            ZStack {
                Color.orange.ignoresSafeArea()

                ScrollView {
                    TextField("Placeholder", text: $text)

                    ForEach(0..<50) { _ in
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 200, height: 200)
                    }
                }
            }
            .navigationTitle("Toolbar")
//            .navigationBarItems(
//                leading: Image(systemName: "heart.fill"),
//                trailing: Image(systemName: "gear")
//            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "heart.fill")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
//                    HStack {
//                        Image(systemName: "house.fill")
                        Image(systemName: "gear")
//                    }
                }
//                ToolbarTitleMenu {
//                    Button("Screen 2") {
//                        paths.append("Screen 2")
//                    }
//                }
            }
//            .navigationBarHidden(true)
//            .toolbar(.hidden, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarTitleMenu { // >>> 在导航条标题后面增加一个下拉菜单，上面那样用也行
                Button("Screen 1") {
                    paths.append("Screen 1")
                }
                Button("Screen 2") {
                    paths.append("Screen 2")
                }
            }
            .navigationDestination(for: String.self) { value in
                Text("New screen: \(value)")
            }
        }
    }
}

struct ToolbarBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarBootcamp()
    }
}
