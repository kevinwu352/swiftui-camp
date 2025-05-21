//
//  SubscriptionBootcamp.swift
//  bootcamp
//
//  Created by Kevin Wu on 5/21/25.
//

import SwiftUI

struct SubscriptionBootcamp: View {

    @State private var counter1 = 0
    @State private var counter2 = 100

    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack {
                SubscriptionView(content: Text("Counter 1: \(counter1.formatted())"), publisher: timer) { _ in
                    counter1 += 1
                }

                Text("Counter 2: \(counter2.formatted())")
                    .onReceive(timer) { _ in
                        counter2 += 1
                    }
            }
            .font(.title)
            .navigationTitle("DevTechie")
        }
    }

}
