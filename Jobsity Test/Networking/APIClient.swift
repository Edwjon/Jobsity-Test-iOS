//
//  APIClient.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/6/25.
//

import UIKit

protocol APIService {
    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void)
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void)
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
}

struct SearchResult: Codable {
    let show: Series
}

class APIClient: APIService {
    private let baseURL = "https://api.tvmaze.com"

    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void) {
        fetch(endpoint: "/shows?page=\(page)", completion: completion)
    }
    
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void) {
        fetch(endpoint: "/search/shows?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") { (result: Result<[SearchResult], Error>) in
            switch result {
            case .success(let searchResults):
                let series = searchResults.map { $0.show }
                completion(.success(series))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        fetch(endpoint: "/shows/\(seriesId)/episodes", completion: completion)
    }
    
    private func fetch<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
