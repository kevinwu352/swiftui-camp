//
//  NativePopoverBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 9/18/23.
//

import SwiftUI

struct NativePopoverBootcamp: View {
    // >>> 原生的小弹窗，从被点击按钮的某个位置弹出来，有尖尖
    @State private var showPopover: Bool = false
    @State private var feedbackOptions: [String] = [
        "Very good 🥳",
        "Average 🙂",
        "Very bad 😡"
    ]
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                

                Spacer()

                Button("Provide feedback?") {
                    showPopover.toggle()
                }
                .padding(20)
                .background(Color.yellow)
                .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), content: {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12, content: {
                            ForEach(feedbackOptions, id: \.self) { option in
                                Button(option) {
                                    
                                }
                                
                                if option != feedbackOptions.last {
                                    Divider()
                                }
                            }
                        })
                        .padding(20)
                    }
                    .presentationCompactAdaptation(.popover) // ios 16.4，传 .sheet 的话会展示成 sheet
                })

                Spacer()
            }
        }
    }
}

struct NativePopoverBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NativePopoverBootcamp()
    }
}
