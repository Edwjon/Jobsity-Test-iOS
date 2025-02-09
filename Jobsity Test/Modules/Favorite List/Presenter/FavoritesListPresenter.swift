import Foundation

protocol FavoritesListPresenterProtocol {
    func loadFavoriteSeries()
    func showSeriesDetails(_ series: Series, delegate: FavoritesListViewDelegate)
}

class FavoritesListPresenter: FavoritesListPresenterProtocol {
    private weak var view: FavoritesListViewProtocol?
    private let interactor: FavoritesListInteractorProtocol
    private let router: FavoritesListRouterProtocol
    
    init(view: FavoritesListViewProtocol, interactor: FavoritesListInteractorProtocol, router: FavoritesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadFavoriteSeries() {
        let favorites = interactor.getFavoriteSeries()
        if favorites.isEmpty {
            view?.showError("No favorite series found.")
        } else {
            view?.showFavorites(favorites)
        }
    }
    
    func showSeriesDetails(_ series: Series, delegate: FavoritesListViewDelegate) {
        router.navigateToSeriesDetail(series: series, delegate: delegate)
    }
}
