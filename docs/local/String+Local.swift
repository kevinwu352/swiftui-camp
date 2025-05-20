//
//  StringExt.swift
//  Design
//
//  Created by Kevin Wu on 4/2/25.
//

import Foundation

public extension String {
    func feed(_ arguments: any CVarArg...) -> String {
        String.localizedStringWithFormat(self, arguments)
    }
}

extension String {
    var loc: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
