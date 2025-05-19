//
//  MenuBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 5/18/23.
//

import SwiftUI

struct MenuBootcamp: View {
    // >>> 原生的弹窗菜单，从被点击的某个位置弹出来，无尖尖

    // 点击的时候执行 primaryAction，长按会弹出三个选项
//    Menu("Options") {
//        Button("Order Now", action: placeOrder)
//        Button("Adjust Order", action: adjustOrder)
//        Button("Cancel", action: cancelOrder)
//    } primaryAction: {
//        justDoIt()
//    }

    var body: some View {
//        Menu("Click me!") {
//            Button("One") {
//                
//            }
//            Button("Two") {
//                
//            }
//            Button("Three") {
//                
//            }
//            Button("Four") {
//                
//            }
//        }

        Menu("My Menu") {
            ControlGroup {
                Button("Uno") {

                }
                Button("Dos") {

                }
//                Button("Tres") {
//
//                }
                Menu("How are you?") {
                    Button("Good") {

                    }
                    Button("Bad") {

                    }
                }
            }
            Button("Two") {

            }
            Menu("Three") {
                Button("Hi") {

                }
                Button("Hello") {

                }

            }
        }
    }
}

struct MenuBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MenuBootcamp()
    }
}
