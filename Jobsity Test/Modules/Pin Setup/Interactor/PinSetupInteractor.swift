import Foundation

protocol PinSetupInteractorProtocol {
    func savePIN(_ pin: String)
}

class PinSetupInteractor: PinSetupInteractorProtocol {
    private let pinKey = "UserPIN"

    func savePIN(_ pin: String) {
        KeychainHelper.shared.save(pin, forKey: pinKey)
    }
}
