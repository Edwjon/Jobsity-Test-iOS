import Foundation
import UIKit

protocol AuthenticationRouterProtocol {
    func navigateToSeriesListView(from view: AuthenticationViewProtocol)
    func navigateToPinSetup(from view: AuthenticationViewProtocol)
}

class AuthenticationRouter: AuthenticationRouterProtocol {
    func navigateToSeriesListView(from view: AuthenticationViewProtocol) {
        guard let viewController = view as? UIViewController else { return }
        let seriesListView = SeriesListView()
        viewController.navigationController?.setViewControllers([seriesListView], animated: true)
    }

    func navigateToPinSetup(from view: AuthenticationViewProtocol) {
        guard let viewController = view as? UIViewController else { return }
        let pinSetupView = PinSetupView()
        viewController.navigationController?.setViewControllers([pinSetupView], animated: true)
    }
}
