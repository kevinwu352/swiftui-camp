//
//  FocusTextFieldBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 11/14/21.
//

import SwiftUI

struct FocusTextFieldBootcamp: View {

    @State private var text: String = ""

    //@FocusState var focusOne: Bool
    //@FocusState var focusTwo: Bool

    enum FocusField: Hashable {
        case one
        case two
    }
    @FocusState var focus: FocusField?

    var body: some View {
        VStack {

            TextField("Placeholder...", text: $text)
                //.focused($focusOne)
                .focused($focus, equals: .one)
                .submitLabel(.route)
                .onSubmit {
                    print("111")
                }

            TextField("Placeholder...", text: $text)
                //.focused($focusTwo)
                .focused($focus, equals: .two)
                .submitLabel(.next)
                .onSubmit {
                    print("222")
                }

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                //focusTwo = true
                focus = .two
            }
        }
    }
}

struct SubmitTextFieldBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FocusTextFieldBootcamp()
    }
}
