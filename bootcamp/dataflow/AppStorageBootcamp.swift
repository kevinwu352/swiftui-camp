//
//  AppStorageBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 2/26/21.
//

import SwiftUI

struct AppStorageBootcamp: View {

    init() {
        let name = UserDefaults.standard.object(forKey: "current-user-name")
        //print("name: \(name)")
    }

  //@AppStorage("current-user-name") var currentUserName: String?
    @AppStorage("current-user-name") var currentUserName = "god"

    var body: some View {
        VStack(spacing: 20) {
            //Text(currentUserName ?? "--")
            Text(currentUserName)

            Button("Save".uppercased()) {
                let name = "Emily"
                currentUserName = name
            }
        }
    }
}

struct AppStorageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageBootcamp()
    }
}
