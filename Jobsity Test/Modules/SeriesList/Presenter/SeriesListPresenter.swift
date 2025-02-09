//
//  SeriesListPresenter.swift.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/6/25.
//

import UIKit

protocol SeriesListPresenterProtocol {
    func loadMoreSeries()
    func searchSeries(query: String)
    func showSeriesDetails(_ series: Series)
}

class SeriesListPresenter: SeriesListPresenterProtocol {
    weak var view: SeriesListViewProtocol?
    private let interactor: SeriesListInteractorProtocol
    private let router: SeriesListRouterProtocol
    private var currentPage = 0
    private var isFetching = false

    init(view: SeriesListViewProtocol, interactor: SeriesListInteractorProtocol, router: SeriesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func loadMoreSeries() {
        guard !isFetching else { return }
        isFetching = true
        interactor.fetchSeries(page: currentPage) { [weak self] result in
            self?.isFetching = false
            switch result {
            case .success(let series):
                self?.currentPage += 1
                self?.view?.showSeries(series)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func searchSeries(query: String) {
        interactor.searchSeries(query: query) { [weak self] result in
            switch result {
            case .success(let series):
                self?.view?.showSeries(series)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func showSeriesDetails(_ series: Series) {
        router.navigateToSeriesDetail(series: series)
    }
}
