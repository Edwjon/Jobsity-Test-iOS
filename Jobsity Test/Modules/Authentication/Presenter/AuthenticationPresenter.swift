//
//  AuthenticationPresenter.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

// MARK: - AuthenticationPresenterProtocol
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
            router.navigateToSeriesListView(from: view as! UIViewController)
        } else {
            view?.showError("Incorrect PIN")
        }
    }
    
    func isPinSet() -> Bool {
        return interactor.isPinSet()
    }
    
    func navigateToPinSetup() {
        router.navigateToPinSetup(from: view as! UIViewController)
    }
}
