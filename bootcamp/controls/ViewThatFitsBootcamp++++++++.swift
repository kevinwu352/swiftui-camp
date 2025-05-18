//
//  ViewThatFitsBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 9/18/23.
//

import SwiftUI

struct ViewThatFitsBootcamp: View {
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            ViewThatFits { // >>> 关注这控件的用法，挺有意思的
                Text("This is some text that I would like to display to the user!")
                Text("This is some text that I would like to display!")
                Text("This is some text!")
            }
        }
        .frame(height: 300)
        .padding(50)
        .font(.headline)
    }
}

struct ViewThatFitsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewThatFitsBootcamp()
    }
}
