//
//  TabViewBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 2/8/21.
//

import SwiftUI

struct TabViewBootcamp: View {

    @State var selected = 0

    var body: some View {


//        TabView(selection: $selected) {
//            Tab("Hello", systemImage: "heart.fill", value: 0) { // ios 18
//                Text("aaa")
//            }
//            .badge(2)
//            Tab("Hello", systemImage: "heart.fill", value: 1) {
//                Text("bbb")
//            }
//        }

        // current
        TabView(selection: $selected) {
            Color.red
                .tabItem { // ios 13-18
                    Image(systemName: "heart.fill")
                    Text("Hello")
                }
                .tag(0)
                .badge("NEW")
            Color.green
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Hello")
                }
                .tag(1)
        }

    }
}

struct TabViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewBootcamp()
    }
}
