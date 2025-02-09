import Foundation
import UIKit

protocol EpisodeDetailInteractorProtocol {}

class EpisodeDetailInteractor: EpisodeDetailInteractorProtocol {
    private let apiClient: APIClient
    private let episode: Episode
    
    init(apiClient: APIClient, episode: Episode) {
        self.apiClient = apiClient
        self.episode = episode
    }
}

