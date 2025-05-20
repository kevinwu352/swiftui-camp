//
//  TabItem.swift
//  Design
//
//  Created by Kevin Wu on 4/3/25.
//

import SwiftUI

public enum TabItem: Hashable, Sendable {
    case home
    case favorites
    case profile

    var icon: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }

    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorites: return Color.green
        case .profile: return Color.blue
        }
    }
}
