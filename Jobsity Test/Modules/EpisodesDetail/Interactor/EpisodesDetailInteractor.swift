//
//  AuthenticationInteractor.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

// MARK: - EpisodeDetailInteractor
protocol EpisodeDetailInteractorProtocol {
    func fetchEpisodeDetails()
}

class EpisodeDetailInteractor: EpisodeDetailInteractorProtocol {
    private let apiClient: APIClient
    private let episode: Episode
    
    init(apiClient: APIClient, episode: Episode) {
        self.apiClient = apiClient
        self.episode = episode
    }
    
    func fetchEpisodeDetails() {
        // No API call needed as all episode data is available.
    }
}

