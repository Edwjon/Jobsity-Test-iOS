import Foundation

protocol PinSetupPresenterProtocol {
    func savePIN(_ pin: String, confirmPin: String)
}

class PinSetupPresenter: PinSetupPresenterProtocol {
    private weak var view: PinSetupViewProtocol?
    private let interactor: PinSetupInteractorProtocol
    private let router: PinSetupRouterProtocol
    
    init(view: PinSetupViewProtocol, interactor: PinSetupInteractorProtocol, router: PinSetupRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func savePIN(_ pin: String, confirmPin: String) {
        if pin.count < 4 {
            view?.showError("PIN must be at least 4 digits.")
            return
        }
        
        if pin != confirmPin {
            view?.showError("PINs do not match.")
            return
        }
        
        interactor.savePIN(pin)
        view?.showSuccess()
    }
}
