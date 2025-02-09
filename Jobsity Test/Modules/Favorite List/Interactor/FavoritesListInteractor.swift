import Foundation

protocol FavoritesListInteractorProtocol {
    func getFavoriteSeries() -> [Series]
}

class FavoritesListInteractor: FavoritesListInteractorProtocol {
    func getFavoriteSeries() -> [Series] {
        return FavoritesManager.shared.getAllFavorites()
    }
}
