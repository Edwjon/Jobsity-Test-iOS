//
//  SeriesDetailInteractor.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/7/25.
//

import UIKit

protocol SeriesDetailInteractorProtocol {
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
}

class SeriesDetailInteractor: SeriesDetailInteractorProtocol {
    private let apiClient: APIService
    
    init(apiClient: APIService = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        apiClient.fetchEpisodes(for: seriesId, completion: completion)
    }
}
