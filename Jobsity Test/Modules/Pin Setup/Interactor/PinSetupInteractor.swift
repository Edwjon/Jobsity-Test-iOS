//
//  AuthenticationInteractor.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation

// MARK: - PinSetupInteractorProtocol
protocol PinSetupInteractorProtocol {
    func savePIN(_ pin: String)
}

class PinSetupInteractor: PinSetupInteractorProtocol {
    private let pinKey = "UserPIN"

    func savePIN(_ pin: String) {
        KeychainHelper.shared.save(pin, forKey: pinKey)
    }
}
