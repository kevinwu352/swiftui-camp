//
//  AccountManager.swift
//  Design
//
//  Created by Kevin Wu on 4/15/25.
//

import SwiftUI
//import KeychainSwift

//@globalActor
//public actor AccountActor {
//    public static let shared = AccountActor()
//}

public let HOME_SHARED = "shared"
//public var HOME_DIR: String { AccountManager.shared.user?.homeDir ?? HOME_SHARED }

public let kAccountNotificationUsernameKey = "username"
public let kAccountNotificationUserKey = "user"

public extension NSNotification.Name {
    static let AccountDidLogin = NSNotification.Name("AccountDidLoginNotification")
    static let AccountDidLogout = NSNotification.Name("AccountDidLogoutNotification")
    static let AccountWillChange = NSNotification.Name("AccountWillChangeNotification")
    static let AccountDidChange = NSNotification.Name("AccountDidChangeNotification")
}

@MainActor
public class AccountManager: ObservableObject {
    public static let shared = AccountManager()

    init() {
        path_create_dir(pathmk("", HOME_SHARED))
        logined = loadCurrentUser()
    }


    @Published public private(set) var logined = false

    @Published public private(set) var username: String?
    @Published public private(set) var user: User?

    // 01::user-states::shared
    // 02::http-main
    private var hooks: [String : (User?) async -> Void] = [:]
    private func fire(_ u: User?) async {
        let list = hooks
            .enumerated()
            .sorted { $0.element.key < $1.element.key }
        for it in list {
            await it.element.value(u)
        }
    }
    public func hook(_ k: String, _ h: @escaping @Sendable (User?) async -> Void) {
        hooks[k] = h
    }


    public func addLogin(_ uname: String, _ usr: User) async {
        guard uname.notEmpty else { return }
        let ui: [String : Any] = [ kAccountNotificationUsernameKey: uname, kAccountNotificationUserKey: usr ]
        NotificationCenter.default.post(name: .AccountWillChange, object: nil, userInfo: ui)

        path_create_dir(pathmk("", uname))

//        KeychainSwift().set(usr.token, forKey: "access_token")

        await fire(usr)
        username = uname
        user = usr
        logined = true
        saveCurrentUser()

//        AppStates.shared.lastUsername = uname

        NotificationCenter.default.post(name: .AccountDidLogin, object: nil, userInfo: ui)
        NotificationCenter.default.post(name: .AccountDidChange, object: nil, userInfo: ui)
    }
    public func removeLogin(_ clear: Bool = false) async {
        guard username?.notEmpty == true else { return }
        NotificationCenter.default.post(name: .AccountWillChange, object: nil)

        if clear {
            path_delete(pathmk("", username))
        }

//        KeychainSwift().delete("access_token")

        await fire(nil)
        username = nil
        user = nil
        logined = false

//        AppStates.shared.lastUsername = nil

        NotificationCenter.default.post(name: .AccountDidLogout, object: nil)
        NotificationCenter.default.post(name: .AccountDidChange, object: nil)
    }
    private func loadCurrentUser() -> Bool {
//        guard let last = AppStates.shared.lastUsername else { return false }
//        if let data = data_read(pathmk("user.json", last)),
//           let object = try? JSONDecoder().decode(User.self, from: data)
//        {
//            username = last
//            user = object
//            return true
//        }
        return false
    }
    private func saveCurrentUser() {
        guard let username = username else { return }
        guard let user = user else { return }
        if let data = try? JSONEncoder().encode(user) {
            data_write(data, pathmk("user.json", username))
        }
    }

}


//@globalActor
//public actor DefaultsActor {
//    public static let shared = DefaultsActor()
//}
//
//@DefaultsActor
//public class Defaults {
//    public static let shared: Defaults = {
//        let ret = Defaults()
//        Task {
//            await AccountManager.shared.hook("dft") { user in
//                await ret.changeUsername(user.username)
////                await Defaults.shared.changeUsername(user.username)
//            }
//        }
//        return ret
//    }()
//
////    func observe() async {
////        await AccountManager.shared.hook("dft") { [weak self] in
////            await self?.changeUsername($0.username)
////            //self?.username = $0.username
////        }
////    }
//
//    var username: String?
//    func changeUsername(_ val: String?) {
//        username = val
//    }
//
//}
