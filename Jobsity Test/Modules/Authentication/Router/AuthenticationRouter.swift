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
        seriesListView.presenter = SeriesListPresenter(view: seriesListView, interactor: SeriesListInteractor(apiClient: APIClient()), router: SeriesListRouter(viewController: seriesListView))
        viewController.navigationController?.setViewControllers([seriesListView], animated: true)
    }

    func navigateToPinSetup(from view: AuthenticationViewProtocol) {
        guard let viewController = view as? UIViewController else { return }
        let pinSetupView = PinSetupView()
        pinSetupView.presenter = PinSetupPresenter(view: pinSetupView, interactor: PinSetupInteractor(), router: PinSetupRouter())
        viewController.navigationController?.setViewControllers([pinSetupView], animated: true)
    }
}
