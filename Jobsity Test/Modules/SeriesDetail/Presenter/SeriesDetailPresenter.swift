import UIKit

protocol SeriesDetailPresenterProtocol {
    func loadEpisodes()
}

class SeriesDetailPresenter: SeriesDetailPresenterProtocol {
    weak var view: SeriesDetailViewProtocol?
    private let interactor: SeriesDetailInteractorProtocol
    private let series: Series
    
    init(view: SeriesDetailViewProtocol, interactor: SeriesDetailInteractorProtocol, series: Series) {
        self.view = view
        self.interactor = interactor
        self.series = series
    }
    
    func loadEpisodes() {
        interactor.fetchEpisodes(for: series.id) { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.view?.showEpisodes(episodes)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}
