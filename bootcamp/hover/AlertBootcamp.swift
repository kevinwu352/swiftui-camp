//
//  AlertBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/28/21.
//

import SwiftUI

struct AlertBootcamp: View {

    @State var showAlert: Bool = false
    @State var backgroundColor: Color = Color.yellow

    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Button("BUTTON 1") {
                    showAlert.toggle()
                }
            }
//            .alert(isPresented: $showAlert, content: { // ios 13-18
//                getAlert()
//            })
            .alert(Text("ttl"), isPresented: $showAlert) { // ios 15
//                Button("OK") {
//                    print("111")
//                }
                Button("ccl", role: .cancel) {
                    print("111")
                }
                Button("doit", role: .destructive) {
                    print("222")
                }
            } message: {
                Text("msg")
            }


        }
    }

}

struct AlertBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp()
    }
}
