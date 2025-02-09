import UIKit

protocol APIService {
    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void)
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void)
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void)
}

struct SearchResult: Codable {
    let show: Series
}

struct SearchPeopleResult: Codable {
    let person: Person
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
    
    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endpoint = "/search/people?q=\(encodedQuery)"
        
        fetch(endpoint: endpoint) { (result: Result<[SearchPeopleResult], Error>) in
            switch result {
            case .success(let results):
                let people = results.map { $0.person }
                completion(.success(people))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
