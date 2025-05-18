//
//  SheetsBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/25/21.
//

import SwiftUI

struct SheetsBootcamp: View {

    @State var showSheet: Bool = false

    var body: some View {
        ZStack {
            Button("click") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet, content: {
                // DO NOT ADD CONDITIONAL LOGIC
                SecondScreen()
            })
            .fullScreenCover(isPresented: $showSheet, content: {
                SecondScreen()
            }) // 放在内外都行，区别是什么？
        }
//        .fullScreenCover(isPresented: $showSheet, content: {
//            SecondScreen()
//        })

        // >>> 三种弹窗弹出来的方式

        // METHOD 1 - SHEET
        //        .sheet(isPresented: $showNewScreen, content: {
        //            NewScreen()
        //        })

        // METHOD 2 - TRANSITION
        //        ZStack {
        //            if showNewScreen {
        //                NewScreen(showNewScreen: $showNewScreen)
        //                    .padding(.top, 100)
        //                    .transition(.move(edge: .bottom))
        //                    .animation(.spring())
        //            }
        //        }
        //        .zIndex(2.0)

        // METHOD 3 - ANIMATION OFFSET
        //        NewScreen(showNewScreen: $showNewScreen)
        //            .padding(.top, 100)
        //            .offset(y: showNewScreen ? 0 : UIScreen.main.bounds.height)
        //            .animation(.linear(duration: 3.0))
    }
}

struct SecondScreen: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.red
                .edgesIgnoringSafeArea(.all)

            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}


struct SheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SheetsBootcamp()
        //SecondScreen()
    }
}
