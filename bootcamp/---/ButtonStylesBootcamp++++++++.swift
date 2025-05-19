//
//  ButtonStylesBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 11/14/21.
//

import SwiftUI

struct ButtonStylesBootcamp: View {
    var body: some View {
        VStack {

            // >>> 改变按钮颜色，赋 role 或 .tint

            Button { } label: {
                Text("automatic")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.automatic)
            .buttonBorderShape(.roundedRectangle(radius: 20))
            .controlSize(.large)

            Button("plain") { }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .controlSize(.large)

            Button("borderless") { }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderless)

            Button("bordered") { }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .controlSize(.regular)
            .buttonStyle(.bordered)

            Button("borderedProminent") { }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
//            .controlSize(.small)

        }
        .padding()
    }
}

struct ButtonStylesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStylesBootcamp()
            .preferredColorScheme(.light)
            
    }
}
