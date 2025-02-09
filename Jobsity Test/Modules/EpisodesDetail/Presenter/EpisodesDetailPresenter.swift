import Foundation

protocol EpisodeDetailPresenterProtocol {
    func loadEpisodeDetails()
}

class EpisodeDetailPresenter: EpisodeDetailPresenterProtocol {
    private weak var view: EpisodeDetailViewProtocol?
    private let interactor: EpisodeDetailInteractorProtocol
    private let episode: Episode
    
    init(view: EpisodeDetailViewProtocol, interactor: EpisodeDetailInteractorProtocol, episode: Episode) {
        self.view = view
        self.interactor = interactor
        self.episode = episode
    }
    
    func loadEpisodeDetails() {
        view?.showEpisodeDetails(episode)
    }
}
