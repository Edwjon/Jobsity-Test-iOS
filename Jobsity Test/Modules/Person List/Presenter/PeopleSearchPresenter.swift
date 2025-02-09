import UIKit

protocol PeopleSearchPresenterProtocol {
    func searchPeople(query: String)
    func showPersonDetail(person: Person)
}

class PeopleSearchPresenter: PeopleSearchPresenterProtocol {
    private weak var view: PeopleSearchViewProtocol?
    private let interactor: PeopleSearchInteractorProtocol
    private let router: PeopleSearchRouterProtocol

    init(view: PeopleSearchViewProtocol, interactor: PeopleSearchInteractorProtocol, router: PeopleSearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func searchPeople(query: String) {
        interactor.searchPeople(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let people):
                    self?.view?.showPeople(people)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func showPersonDetail(person: Person) {
        router.navigateToPersonDetail(person: person)
    }
}
