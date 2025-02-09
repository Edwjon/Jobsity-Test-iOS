import Foundation
import UIKit

protocol PersonDetailInteractorProtocol {}

class PersonDetailInteractor: PersonDetailInteractorProtocol {
    private let apiClient: APIClient
    private let person: Person
    
    init(apiClient: APIClient, person: Person) {
        self.apiClient = apiClient
        self.person = person
    }
}
