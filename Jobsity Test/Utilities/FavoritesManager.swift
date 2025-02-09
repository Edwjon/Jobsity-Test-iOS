import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favorite_series"
    
    private init() {}

    func getAllFavorites() -> [Series] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let series = try? JSONDecoder().decode([Series].self, from: data) else {
            return []
        }
        return series
    }

    func addFavorite(series: Series) {
        var favorites = getAllFavorites()
        if !favorites.contains(where: { $0.id == series.id }) {
            favorites.append(series)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(seriesId: Int) {
        var favorites = getAllFavorites()
        favorites.removeAll { $0.id == seriesId }
        saveFavorites(favorites)
    }

    func isFavorite(seriesId: Int) -> Bool {
        return getAllFavorites().contains { $0.id == seriesId }
    }

    private func saveFavorites(_ series: [Series]) {
        if let data = try? JSONEncoder().encode(series) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
