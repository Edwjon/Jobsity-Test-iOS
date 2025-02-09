//
//  SeriesListRouter.swift.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/6/25.
//

import UIKit

protocol SeriesListRouterProtocol {
    func navigateToSeriesDetail(series: Series)
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
}
