//
//  UserDefaultsManager.swift
//  SwiftUIStepsTests
//
//  Created by 백래훈 on 9/24/25.
//

import Foundation

final class UserDefaultsManager {
    private let favoritesKey = "favorites"

    func saveFavorites(_ items: [String]) {
        UserDefaults.standard.set(items, forKey: favoritesKey)
    }

    func loadFavorites() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
}
