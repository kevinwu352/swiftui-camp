//
//  PickerBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 2/5/21.
//

import SwiftUI

struct PickerBootcamp: View {
    
    @State var selection: String = "Most Recent"
    let filterOptions: [String] = [
        "Most Recent", "Most Popular", "Most Liked"
    ]
    
//    init() {
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
//        
//        let attributes: [NSAttributedString.Key:Any] = [
//            .foregroundColor : UIColor.white
//        ]
//        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
//    }
    
    var body: some View {

        // >>> picker 用法
        // https://bugfender.com/blog/swiftui-pickers/
        // https://sarunw.com/posts/swiftui-form-picker-styles/

        // .segmented
        // .wheel 在 List 里外都是滚轮

        // .palette 在 menu 外面的话和 .segmented 一样

        // .menu 弹窗出来几个选项，PopOver 那样，无尖尖。在 List 里面时，是一行，且会把标题显示出来
        // .inline 在外面是滚轮。但在 List 里面时，会把选项全展示，选中的后面有个勾勾

        // .navigationLink 其它的只要求包在 List/Form 里，这个需要包在 NavigationStack，点击的时候会跳转到它自己建的子页面，展示所有选项，选中再弹回来

//        NavigationStack {
            List {
                Picker(selection: $selection, label: Text("Picker")) {
                    ForEach(filterOptions.indices) { index in
                        Text(filterOptions[index])
                            .tag(filterOptions[index])
                    }
                }
                .pickerStyle(.palette)
                //.background(Color.red)
            }
//        }




//        Picker(
//            selection: $selection,
//            label:
//                HStack {
//                    Text("Filter:")
//                    Text(selection)
//                }
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .padding(.horizontal)
//                .background(Color.blue)
//                .cornerRadius(10)
//                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
//            ,
//            content: {
//                ForEach(filterOptions, id: \.self) { option in
//                    HStack {
//                        Text(option)
//                        Image(systemName: "heart.fill")
//                    }
//                    .tag(option)
//                }
//        })
//            .pickerStyle(MenuPickerStyle())
        
//        VStack {
//            HStack {
//                Text("Age:")
//                Text(selection)
//            }
//
//            Picker(
//                selection: $selection,
//                label: Text("Picker"),
//                content: {
//                    ForEach(18..<100) { number in
//                        Text("\(number)")
//                            .font(.headline)
//                            .foregroundColor(.red)
//                            .tag("\(number)")
//                    }
//            })
//                .pickerStyle(WheelPickerStyle())
//                //.background(Color.gray.opacity(0.3))
//        }
        
    }
}

struct PickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PickerBootcamp()
    }
}
