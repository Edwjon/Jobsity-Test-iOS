//
//  AuthenticationPresenter.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation

// MARK: - EpisodeDetailPresenter
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
