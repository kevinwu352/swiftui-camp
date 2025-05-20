//
//  SharedStrings.swift
//  Design
//
//  Created by Kevin Wu on 4/5/25.
//

import SwiftUI

// put strings in main bundle, export them here
//   Text(.welcome_msg)
//   Text("welcome_msg")

public extension LocalizedStringKey {
    //@MainActor static let welcome_msg = LocalizedStringKey(._welcome_msg)
    static var welcome_msg: LocalizedStringKey { .init(._welcome_msg) }
}

private extension String {
    static let _welcome_msg = "_welcome_msg"
}
