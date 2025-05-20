//
//  Keychain.swift
//  Design
//
//  Created by Kevin Wu on 4/28/25.
//

import Foundation
import Factory
import KeychainSwift

public extension Container {
    var keychain: Factory<Keychain> {
        self { .standard }.cached
    }
}

public final class Keychain: @unchecked Sendable {
    let raw: KeychainSwift
    public init(prefix: String = "") {
        // print("[life] keychain init [prefix:\(prefix)]")
        raw = KeychainSwift(keyPrefix: prefix)
    }
    // deinit { print("[life] keychain deinit") }
}
public extension Keychain {
    static var standard: Keychain {
        Keychain(prefix: "")
    }
    static var preview: Keychain {
        Keychain(prefix: "preview")
    }
}

public extension Keychain {
    var lastUsername: String? {
        get { raw.get("last_username") }
        set {
            if let val = newValue {
                raw.set(val, forKey: "last_username")
            } else {
                raw.delete("last_username")
            }
        }
    }
    var accessToken: String? {
        get { raw.get("access_token") }
        set {
            if let val = newValue {
                raw.set(val, forKey: "access_token")
            } else {
                raw.delete("access_token")
            }
        }
    }
}
