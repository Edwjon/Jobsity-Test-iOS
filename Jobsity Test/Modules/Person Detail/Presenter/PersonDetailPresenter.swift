import Foundation

protocol PersonDetailPresenterProtocol {
    func loadPersonDetails()
}

class PersonDetailPresenter: PersonDetailPresenterProtocol {
    private weak var view: PersonDetailViewProtocol?
    private let interactor: PersonDetailInteractorProtocol
    private let person: Person
    
    init(view: PersonDetailViewProtocol, interactor: PersonDetailInteractorProtocol, person: Person) {
        self.view = view
        self.interactor = interactor
        self.person = person
    }
    
    func loadPersonDetails() {
        view?.showPersonDetails(person)
    }
}
