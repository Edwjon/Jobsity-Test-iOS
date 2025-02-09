import XCTest
@testable import Jobsity_Test

class PinSetupTests: XCTestCase {
    
    var presenter: PinSetupPresenter!
    var mockView: MockPinSetupView!
    var mockInteractor: MockPinSetupInteractor!
    var mockRouter: MockPinSetupRouter!

    override func setUp() {
        super.setUp()
        mockView = MockPinSetupView()
        mockInteractor = MockPinSetupInteractor()
        mockRouter = MockPinSetupRouter()
        
        presenter = PinSetupPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testSavePin_WithShortPin_ShouldShowError() {
        presenter.savePIN("12", confirmPin: "12")
        
        XCTAssertTrue(mockView.didShowError, "It should show an error if the PIN is less than 4 digits.")
        XCTAssertEqual(mockView.errorMessage, "PIN must be at least 4 digits.")
    }

    func testSavePin_WithMismatchedPins_ShouldShowError() {
        presenter.savePIN("1234", confirmPin: "5678")
        
        XCTAssertTrue(mockView.didShowError, "It should show an error if the PINs do not match.")
        XCTAssertEqual(mockView.errorMessage, "PINs do not match.")
    }

    func testSavePin_WithValidPin_ShouldSaveAndNavigate() {
        presenter.savePIN("1234", confirmPin: "1234")
        
        XCTAssertTrue(mockInteractor.didSavePin, "The interactor should have saved the PIN.")
        XCTAssertTrue(mockView.didShowSuccess, "It should navigate to the authentication screen.")
    }
}

class MockPinSetupView: PinSetupViewProtocol {
    var didShowError = false
    var errorMessage: String?
    var didShowSuccess = false

    func showError(_ message: String) {
        didShowError = true
        errorMessage = message
    }

    func showSuccess() {
        didShowSuccess = true
    }
}

class MockPinSetupInteractor: PinSetupInteractorProtocol {
    var didSavePin = false

    func savePIN(_ pin: String) {
        didSavePin = true
    }
}

class MockPinSetupRouter: PinSetupRouterProtocol {
    var didNavigateToAuthView = false

    func navigateToAuthenticationView(from view: UIViewController) {
        didNavigateToAuthView = true
    }
}
