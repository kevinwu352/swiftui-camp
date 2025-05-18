//
//  ActionsheetBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/29/21.
//

import SwiftUI

struct ActionsheetBootcamp: View {
    
    @State var showActionSheet: Bool = false

    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text("@username")
                Spacer()
                Button(action: {
                    showActionSheet.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                })
                .accentColor(.primary)
            }
            .padding(.horizontal)
            
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
            
        }
//        .actionSheet(isPresented: $showActionSheet, content: getActionSheet) // ios 13-18
        .confirmationDialog(Text("ttl"), isPresented: $showActionSheet) { // ios 15
            Button("ccl", role: .cancel) {
                print("111")
            }
            Button("doit", role: .destructive) {
                print("222")
            }
            Button("aaa") {
                print("aa")
            }
            Button("bbb") {
                print("bb")
            }
        } message: {
            Text("msg")
        }

    }
}

struct ActionsheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActionsheetBootcamp()
    }
}
