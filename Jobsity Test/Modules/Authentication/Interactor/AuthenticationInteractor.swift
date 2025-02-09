import Foundation

protocol AuthenticationInteractorProtocol {
    func verifyPIN(_ pin: String) -> Bool
    func isPinSet() -> Bool
}

class AuthenticationInteractor: AuthenticationInteractorProtocol {
    private let pinKey = "UserPIN"

    func verifyPIN(_ pin: String) -> Bool {
        return KeychainHelper.shared.retrieve(forKey: pinKey) == pin
    }

    func isPinSet() -> Bool {
        return KeychainHelper.shared.retrieve(forKey: pinKey) != nil
    }
}
