//
//  ToggleBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 2/5/21.
//

import SwiftUI

struct ToggleBootcamp: View {
    
    @State var toggleIsOn: Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Status:")
                Text(toggleIsOn ? "Online" : "Offline")
            }
            .font(.title)

            Toggle("aaa", systemImage: "plus", isOn: $toggleIsOn)
                .toggleStyle(.button)

            Toggle(
                isOn: $toggleIsOn,
                label: {
                Text("Change status")
            })
                .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))))
            
            Spacer()
        }
        .padding(.horizontal, 100)
    }
}

struct ToggleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToggleBootcamp()
    }
}



struct EmailList: Identifiable {
    var id: String
    var isSubscribed = false
}
struct ToggleAdvanced: View {
    @State var lists = [
        EmailList(id: "Monthly Updates", isSubscribed: true),
        EmailList(id: "News Flashes", isSubscribed: true),
        EmailList(id: "Special Offers", isSubscribed: true)
    ]
    var body: some View {
        Form {
            Section {
                ForEach($lists) { $list in
                    Toggle(list.id, isOn: $list.isSubscribed)
                }
            }
            Section {
                // >>> 注意这个高级用法
                Toggle("Subscribe to all", sources: $lists, isOn: \.isSubscribed)
            }
        }
    }
}


// >>> 注意这 toggle 点击的时候关不掉
// Toggle(isOn: .constant(true)) {
//     Text("Show advanced options")
// }
