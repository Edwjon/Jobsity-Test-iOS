//
//  AuthenticationRouter.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

// MARK: - PinSetupRouterProtocol
protocol PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController)
}

class PinSetupRouter: PinSetupRouterProtocol {
    func navigateToAuthenticationView(from view: UIViewController) {
        let authenticationView = AuthenticationView()
        view.navigationController?.setViewControllers([authenticationView], animated: true)
    }
}
