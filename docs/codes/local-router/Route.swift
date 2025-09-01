//
//  Route.swift
//  Wallet
//
//  Created by Kevin Wu on 5/3/25.
//

import SwiftUI
import Design
import Factory

enum Route: Hashable, Identifiable {
    public var id: Int { hashValue }

    case asset(symbol: String)
}

extension Route {
    @MainActor
    var view: some View {
        switch self {
        case let .asset(symbol):
            AssetRouter.createView(symbol: symbol)
        }
    }
    @MainActor
    var initial: some View {
        switch self {
        case let .asset(symbol):
            AssetRouter.createInitial(symbol: symbol)
                .applyRoutes()
        }
    }
}

extension View {
    func applyRoute() -> some View {
        navDestination(for: Route.self) { $0.view }
    }
}

extension View {
    func applySheets1() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return sheet(item: $router.modal1.sheet) { route in
            NavStack(path: $router.modal1.paths) { route.initial }
                .interactiveDismissDisabled(!router.modal1.draggable)
                .applySheets2()
                .applyCovers2()
        }
    }
    func applySheets2() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return sheet(item: $router.modal2.sheet) { route in
            NavStack(path: $router.modal2.paths) { route.initial }
                .interactiveDismissDisabled(!router.modal2.draggable)
                .applySheets3()
                .applyCovers3()
        }
    }
    func applySheets3() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return sheet(item: $router.modal3.sheet) { route in
            NavStack(path: $router.modal3.paths) { route.initial }
                .interactiveDismissDisabled(!router.modal3.draggable)
                .applySheets4()
                .applyCovers4()
        }
    }
    func applySheets4() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return sheet(item: $router.modal4.sheet) { route in
            NavStack(path: $router.modal4.paths) { route.initial }
                .interactiveDismissDisabled(!router.modal4.draggable)
                .applySheets5()
                .applyCovers5()
        }
    }
    func applySheets5() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return sheet(item: $router.modal5.sheet) { route in
            NavStack(path: $router.modal5.paths) { route.initial }
                .interactiveDismissDisabled(!router.modal5.draggable)
        }
    }
}

extension View {
    func applyCovers1() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return fullScreenCover(item: $router.modal1.cover) { route in
            NavStack(path: $router.modal1.paths) { route.initial }
                .applySheets2()
                .applyCovers2()
        }
    }
    func applyCovers2() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return fullScreenCover(item: $router.modal2.cover) { route in
            NavStack(path: $router.modal2.paths) { route.initial }
                .applySheets3()
                .applyCovers3()
        }
    }
    func applyCovers3() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return fullScreenCover(item: $router.modal3.cover) { route in
            NavStack(path: $router.modal3.paths) { route.initial }
                .applySheets4()
                .applyCovers4()
        }
    }
    func applyCovers4() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return fullScreenCover(item: $router.modal4.cover) { route in
            NavStack(path: $router.modal4.paths) { route.initial }
                .applySheets5()
                .applyCovers5()
        }
    }
    func applyCovers5() -> some View {
        @Bindable var router = Container.shared.lcrouter()
        return fullScreenCover(item: $router.modal5.cover) { route in
            NavStack(path: $router.modal5.paths) { route.initial }
        }
    }
}
