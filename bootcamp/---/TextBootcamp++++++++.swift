//
//  TextBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/15/21.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Hello, World!".capitalized)
            //.font(.body)
            //.fontWeight(.semibold)
            //.bold()
            //.underline()
//            .underline(true, color: Color.red)
//            .italic()
//            .strikethrough(true, color: Color.green)
            //.font(.system(size: 24, weight: .semibold, design: .serif))
            //.baselineOffset(-50.0)
            //.kerning(10)
            .multilineTextAlignment(.leading)
            .foregroundColor(.red)
            .frame(width: 200, height: 100, alignment: .leading)
            .minimumScaleFactor(0.1)

        // >>> 关注限制行数的用法
        // .lineLimit(2, reservesSpace: true)
        // .lineLimit(2...)
        // .truncationMode(.middle)

        // >>> 关注这里格式化的用法，貌似只在 LocalizedKey 里面能用
        // Text("\(celsius, specifier: "%.2f") Celsius is \(celsius * 9 / 5 + 32, specifier: "%.2f") Fahrenheit")

        // >>> 关注格式化的用法
        // Text(ingredients, format: .list(type: .and))
        // let length = Measurement(value: 225, unit: UnitLength.centimeters) 这里是米
        // Text(length, format: .measurement(width: .wide)) // 显示出来的时候会根据 local 自动换算单位
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
