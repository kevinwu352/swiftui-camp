//
//  LocalView.swift
//  Home
//
//  Created by Kevin Wu on 4/6/25.
//

import SwiftUI

struct LocalView: View {
    var body: some View {
        VStack {
            Txt("my_name_\( "John" )")

            Txt("i_have_\( 1 )")
            Txt("i_have_\( 2 )")

            Txt("i_have_\( 1 )_\( 1 )")
            Txt("i_have_\( 1 )_\( 2 )")
            Txt("i_have_\( 2 )_\( 1 )")
            Txt("i_have_\( 2 )_\( 2 )")
        }
    }
}

#Preview {
    LocalView()
}
