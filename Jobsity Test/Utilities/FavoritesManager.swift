//
//  FavoritesManager.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation

class FavoritesManager {
    private let favoritesKey = "favoriteSeries"
    static let shared = FavoritesManager()
    
    private init() {}
    
    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func addFavorite(seriesId: Int) {
        var favorites = getFavorites()
        if !favorites.contains(seriesId) {
            favorites.append(seriesId)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(seriesId: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == seriesId }
        saveFavorites(favorites)
    }
    
    func isFavorite(seriesId: Int) -> Bool {
        return getFavorites().contains(seriesId)
    }
    
    private func saveFavorites(_ favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
}
