import UIKit
import Foundation

protocol PeopleSearchInteractorProtocol {
    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void)
}

class PeopleSearchInteractor: PeopleSearchInteractorProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        apiClient.searchPeople(query: query, completion: completion)
    }
}
