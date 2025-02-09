import XCTest
@testable import Jobsity_Test

class AuthenticationTests: XCTestCase {
    
    var presenter: AuthenticationPresenter!
    var mockView: MockAuthenticationView!
    var mockInteractor: MockAuthenticationInteractor!
    var mockRouter: MockAuthenticationRouter!

    override func setUp() {
        super.setUp()
        mockView = MockAuthenticationView()
        mockInteractor = MockAuthenticationInteractor()
        mockRouter = MockAuthenticationRouter()
        
        presenter = AuthenticationPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testAuthenticateUser_WithCorrectPin_ShouldNavigateToSeriesList() {
        mockInteractor.isPinValid = true
        
        presenter.authenticateUser(with: "1234")
        
        XCTAssertTrue(mockRouter.didNavigateToSeriesList, "The user should navigate to the series screen if the PIN is correct.")
    }

    func testAuthenticateUser_WithIncorrectPin_ShouldShowError() {
        mockInteractor.isPinValid = false
        
        presenter.authenticateUser(with: "9999")
        
        XCTAssertTrue(mockView.didShowError, "An error should be shown if the PIN is incorrect.")
    }

    func testIsPinSet_ShouldReturnCorrectValue() {
        mockInteractor.isPinSetResult = true
        XCTAssertTrue(presenter.isPinSet(), "It should indicate that the PIN is set.")

        mockInteractor.isPinSetResult = false
        XCTAssertFalse(presenter.isPinSet(), "It should indicate that the PIN is not set.")
    }

    func testNavigateToPinSetup_ShouldCallRouter() {
        presenter.navigateToPinSetup()
        
        XCTAssertTrue(mockRouter.didNavigateToPinSetup, "It should navigate to the PIN setup.")
    }
}

class MockAuthenticationView: UIViewController, AuthenticationViewProtocol {
    var didShowError = false

    func showError(_ message: String) {
        didShowError = true
    }
}

class MockAuthenticationInteractor: AuthenticationInteractorProtocol {
    var isPinValid = false
    var isPinSetResult = false

    func verifyPIN(_ pin: String) -> Bool {
        return isPinValid
    }

    func isPinSet() -> Bool {
        return isPinSetResult
    }
}

class MockAuthenticationRouter: AuthenticationRouterProtocol {
    func navigateToSeriesListView(from view: any Jobsity_Test.AuthenticationViewProtocol) {
        didNavigateToSeriesList = true
    }
    
    func navigateToPinSetup(from view: any Jobsity_Test.AuthenticationViewProtocol) {
        didNavigateToPinSetup = true
    }
    
    var didNavigateToSeriesList = false
    var didNavigateToPinSetup = false
}
