//
//  Defaults.swift
//  Design
//
//  Created by Kevin Wu on 4/28/25.
//

import Foundation
import Factory

public extension Container {
    var defaults: Factory<Defaults> {
        self { .standard }.cached
    }
}

public final class Defaults: @unchecked Sendable {
    let raw: UserDefaults?
    public init(suite: String = "") {
        // print("[life] defaults init [suite:\(suite)]")
        raw = suite.isEmpty ? .standard : .init(suiteName: suite)
    }
    // deinit { print("[life] defaults deinit") }
}
public extension Defaults {
    static var standard: Defaults {
        Defaults(suite: "")
    }
    static var preview: Defaults {
        Defaults(suite: "preview")
    }
}

public extension Defaults {
    var boardedVersion: String? {
        get { raw?.string(forKey: "boarded_version") }
        set { raw?.set(newValue, forKey: "boarded_version") }
    }
}
