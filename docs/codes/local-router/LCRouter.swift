//
//  LCRouter.swift
//  Wallet
//
//  Created by Kevin Wu on 9/1/25.
//

import SwiftUI
import Design
import Factory

extension Container {
    @MainActor
    var lcrouter: Factory<LCRouter> {
        self { @MainActor in LCRouter() }.scope(.session)
    }
}

@MainActor
@Observable
final class LCRouter {
    var modal1 = Modal<Route>()
    var modal2 = Modal<Route>()
    var modal3 = Modal<Route>()
    var modal4 = Modal<Route>()
    var modal5 = Modal<Route>()

    func present(_ route: Route, fullScreen: Bool = false, isDraggable: Bool = true) {
        guard modal1.present(route, fullScreen: fullScreen, isDraggable: isDraggable) == false else { return }
        guard modal2.present(route, fullScreen: fullScreen, isDraggable: isDraggable) == false else { return }
        guard modal3.present(route, fullScreen: fullScreen, isDraggable: isDraggable) == false else { return }
        guard modal4.present(route, fullScreen: fullScreen, isDraggable: isDraggable) == false else { return }
        guard modal5.present(route, fullScreen: fullScreen, isDraggable: isDraggable) == false else { return }
        modal5.paths.append(route)
    }

    func dismiss() {
        guard modal5.dismiss() == false else { return }
        guard modal4.dismiss() == false else { return }
        guard modal3.dismiss() == false else { return }
        guard modal2.dismiss() == false else { return }
        guard modal1.dismiss() == false else { return }
    }
    func dismissAll() {
        modal5.dismiss()
        modal4.dismiss()
        modal3.dismiss()
        modal2.dismiss()
        modal1.dismiss()
    }

    func push<R: Hashable>(_ route: R, tab: TabBarItem? = nil) {
        guard modal5.push(route) == false else { return }
        guard modal4.push(route) == false else { return }
        guard modal3.push(route) == false else { return }
        guard modal2.push(route) == false else { return }
        guard modal1.push(route) == false else { return }
        Container.shared.router().push(route, tab: tab)
    }

    func pop(_ count: Int = 1, tab: TabBarItem? = nil) {
        guard modal5.pop(count) == false else { return }
        guard modal4.pop(count) == false else { return }
        guard modal3.pop(count) == false else { return }
        guard modal2.pop(count) == false else { return }
        guard modal1.pop(count) == false else { return }
        Container.shared.router().pop(count, tab: tab)
    }

}
