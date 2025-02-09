import Foundation
import UIKit

protocol PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController)
}

class PinSetupRouter: PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController) {
        let authenticationView = AuthenticationView()
        view.navigationController?.setViewControllers([authenticationView], animated: true)
    }
}
