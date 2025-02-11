import Foundation
import UIKit

class AppRouter {
    static func setInitialViewController(window: UIWindow?) {
        guard let window = window else { return }

        let navigationController = UINavigationController()

        if KeychainHelper.shared.retrieve(forKey: "UserPIN") != nil {
            let authenticationRouter = AuthenticationRouter()
            let authenticationView = AuthenticationView()
            authenticationView.presenter = AuthenticationPresenter(view: authenticationView, interactor: AuthenticationInteractor(), router: authenticationRouter)
            navigationController.viewControllers = [authenticationView]
        } else {
            let pinSetupRouter = PinSetupRouter()
            let pinSetupView = PinSetupView()
            pinSetupView.presenter = PinSetupPresenter(view: pinSetupView, interactor: PinSetupInteractor(), router: pinSetupRouter)
            navigationController.viewControllers = [pinSetupView]
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
