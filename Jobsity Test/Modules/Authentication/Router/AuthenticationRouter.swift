//
//  AuthenticationRouter.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

// MARK: - AuthenticationRouterProtocol
protocol AuthenticationRouterProtocol {
    func navigateToSeriesListView(from view: UIViewController)
    func navigateToPinSetup(from view: UIViewController)
}

class AuthenticationRouter: AuthenticationRouterProtocol {
    func navigateToSeriesListView(from view: UIViewController) {
        let seriesListView = SeriesListView()
        view.navigationController?.setViewControllers([seriesListView], animated: true)
    }
    
    func navigateToPinSetup(from view: UIViewController) {
        let pinSetupView = PinSetupView()
        view.navigationController?.setViewControllers([pinSetupView], animated: true)
    }
}
