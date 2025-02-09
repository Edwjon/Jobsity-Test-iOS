import Foundation
import UIKit

protocol FavoritesListRouterProtocol {
    func navigateToSeriesDetail(series: Series, delegate: FavoritesListViewDelegate)
}

class FavoritesListRouter: FavoritesListRouterProtocol {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToSeriesDetail(series: Series, delegate: FavoritesListViewDelegate) {
        let detailVC = SeriesDetailView(series: series)
        detailVC.favoritesDelegate = delegate
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
