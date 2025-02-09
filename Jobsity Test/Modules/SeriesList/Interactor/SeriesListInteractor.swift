//
//  SeriesListInteractor.swift.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/6/25.
//

import UIKit

protocol SeriesListInteractorProtocol {
    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void)
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void)
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
}

class SeriesListInteractor: SeriesListInteractorProtocol {
    private let apiClient: APIService

    init(apiClient: APIService = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void) {
        apiClient.fetchSeries(page: page, completion: completion)
    }
    
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void) {
        apiClient.searchSeries(query: query, completion: completion)
    }
    
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        apiClient.fetchEpisodes(for: seriesId, completion: completion)
    }
}
