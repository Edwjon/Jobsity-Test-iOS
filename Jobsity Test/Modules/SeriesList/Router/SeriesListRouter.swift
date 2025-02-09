import UIKit

protocol SeriesListRouterProtocol {
    func navigateToSeriesDetail(series: Series)
    func navigateToFavorites()
    func navigateToPeopleSearch()
}

class SeriesListRouter: SeriesListRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToSeriesDetail(series: Series) {
        let detailVC = SeriesDetailView(series: series)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func navigateToFavorites() {
        let favoritesSeriesView = FavoritesListView()
        viewController?.navigationController?.pushViewController(favoritesSeriesView, animated: true)
    }
    
    func navigateToPeopleSearch() {
        let peopleSearchView = PeopleSearchView()
        viewController?.navigationController?.pushViewController(peopleSearchView, animated: true)
    }
}
