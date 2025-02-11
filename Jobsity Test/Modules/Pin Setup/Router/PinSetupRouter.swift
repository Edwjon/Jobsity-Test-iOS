import Foundation
import UIKit

protocol PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController)
}

class PinSetupRouter: PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController) {
        let authenticationView = AuthenticationView()
        authenticationView.presenter = AuthenticationPresenter(view: authenticationView, interactor: AuthenticationInteractor(), router: AuthenticationRouter())
        view.navigationController?.setViewControllers([authenticationView], animated: true)
    }
}
