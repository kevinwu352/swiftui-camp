//
//  AssetView.swift
//  Wallet
//
//  Created by Kevin Wu on 5/3/25.
//

import SwiftUI
import Design
import Factory

struct AssetView: View {
    let symbol: String
    var body: some View {
        ZStack {
            Color.kViewBg.ignoresSafeArea()
            VStack {
                Text("<head>")
                Spacer()
                HStack {
                    NavigationLink(value: Routes.settings) {
                        Image(systemName: "gear").padding()
                    }
                    NavigationLink(value: Route.asset(symbol: "BTC")) {
                        Image(systemName: "bitcoinsign").padding()
                    }
                }
                HStack {
                    Button {
                        let router = Container.shared.lcrouter()
                        router.present(.asset(symbol: "BTC"), fullScreen: false, isDraggable: false)
                    } label: { Image(systemName: "bitcoinsign").padding() }
                    Button {
                        let router = Container.shared.lcrouter()
                        router.present(.asset(symbol: "ETH"), fullScreen: true, isDraggable: false)
                    } label: { Image(systemName: "bitcoinsign").padding() }
                }
                HStack {
                    Button {
                        let router = Container.shared.lcrouter()
                        // router.push(Route.asset(symbol: "ETH"))
                        // router.pop()
                        // router.dismiss()
                        // router.dismissAll()
                        // router.pop(Int.max)
                    } label: { Image(systemName: "arrowshape.backward").padding() }
                }
                Spacer()
                Text("<foot>")
            }
        }
        .navBarTitleView(Text("asset_title_\(symbol)"))
    }
}

#Preview {
    AssetView(symbol: "BTC")
}
