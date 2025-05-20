//
//  AppPreferences.swift
//  Design
//
//  Created by Kevin Wu on 4/28/25.
//

import Foundation
import Factory

public extension Container {
    var preferences: Factory<AppPreferences> {
        self { .standard }.cached
    }
}

@Observable
public class AppPreferences: Storage, @unchecked Sendable {

    public init(inMemory: Bool = false) {
        // print("[life] preferences init")
        super.init(path: inMemory ? "" : pathmk("storage-app-shared.json", nil, .cachesDirectory))

        if let code = getString(Keys.theme) {
            theme = Theme(rawValue: code)
        }
        if let code = getString(Keys.language) {
            language = Language(rawValue: code)
        }
    }
    // deinit { print("[life] preferences deinit") }

    struct Keys {
        static let theme = "theme"
        static let language = "language"
    }

    public var theme: Theme? {
        willSet { setString(newValue?.rawValue, Keys.theme) }
    }
    public var language: Language? {
        willSet { setString(newValue?.rawValue, Keys.language) }
    }

}

public extension AppPreferences {
    static var standard: AppPreferences {
        AppPreferences(inMemory: false)
    }
    static var preview: AppPreferences {
        AppPreferences(inMemory: true)
    }
}
