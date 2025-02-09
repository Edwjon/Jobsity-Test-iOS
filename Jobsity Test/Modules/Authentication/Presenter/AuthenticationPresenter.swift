import Foundation
import UIKit

protocol AuthenticationPresenterProtocol {
    func authenticateUser(with pin: String)
    func navigateToPinSetup()
    func isPinSet() -> Bool
}

class AuthenticationPresenter: AuthenticationPresenterProtocol {
    private weak var view: AuthenticationViewProtocol?
    private let interactor: AuthenticationInteractorProtocol
    private let router: AuthenticationRouterProtocol
    
    init(view: AuthenticationViewProtocol, interactor: AuthenticationInteractorProtocol, router: AuthenticationRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func authenticateUser(with pin: String) {
        if interactor.verifyPIN(pin) {
            if let viewController = view as? UIViewController {
                router.navigateToSeriesListView(from: viewController as! AuthenticationViewProtocol)
            }
        } else {
            view?.showError("Incorrect PIN")
        }
    }
    
    func isPinSet() -> Bool {
        return interactor.isPinSet()
    }
    
    func navigateToPinSetup() {
        router.navigateToPinSetup(from: view as! UIViewController as! AuthenticationViewProtocol)
    }
}
