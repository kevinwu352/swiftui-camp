//
//  Txt.swift
//  Home
//
//  Created by Kevin Wu on 4/6/25.
//

import SwiftUI

struct Txt: View {
    let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }
    var body: some View {
        Text(key, bundle: .module, comment: "")
    }
}

#Preview {
    Txt("key")
}
