//
//  ListBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/28/21.
//

import SwiftUI

// >>> List 用法

// List
//   Section
//     ForEach
//
// List
//   ForEach

// List(0..<100) { i in // 只会加载显示出来的行
//     ChildView(name: "\(i)")
// }
// List {
//     ForEach(0..<100) { i in // 只会加载显示出来的行
//         ChildView(name: "\(i)")
//     }
// }

// .scrollContentBackground(.hidden) // 感觉主要用在 group 类型的时候，好像 plain 后面没颜色
// .background(.purple)

// 设置每行背景
// .listRowBackground(Color.blue)

// listRowSeparator() for controlling whether separators are visible or not
// listRowSeparatorTint() for controlling the separator color.

// swipeActions 的第一个会在长滑的时候执行，除非手动关闭这功能 allowsFullSwipe: false

struct ListBootcamp: View {
    
    @State var fruits: [String] = [
        "apple", "orange", "banana", "peach"
    ]
    @State var veggies: [String] = [
        "tomato", "potato", "carrot"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header:
                        HStack {
                            Text("Fruits")
                            Image(systemName: "flame.fill")
                        }
                        .font(.headline)
                        .foregroundColor(.orange)
                ) {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit.capitalized)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.blue)
                }
                
                Section(header: Text("Veggies")) {
                    ForEach(veggies, id: \.self) { veggies in
                        Text(veggies.capitalized)
                    }
                }
            }
            .accentColor(.purple)
            //.listStyle(SidebarListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
        }
        .accentColor(.red)
    }
    
    var addButton: some View {
        Button("Add", action: {
            add()
        })
    }
    
    func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func add() {
        fruits.append("Coconut")
    }
}

struct ListBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcamp()
    }
}
