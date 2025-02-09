import XCTest
@testable import Jobsity_Test

class PersonDetailTests: XCTestCase {
    
    var presenter: PersonDetailPresenter!
    var mockView: MockPersonDetailView!
    var mockInteractor: MockPersonDetailInteractor!
    var mockRouter: MockPersonDetailRouter!
    
    let samplePerson = Person(
        id: 1,
        name: "Bryan Cranston",
        image: Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg")
    )
    
    override func setUp() {
        super.setUp()
        mockView = MockPersonDetailView()
        mockInteractor = MockPersonDetailInteractor()
        mockRouter = MockPersonDetailRouter()
        
        presenter = PersonDetailPresenter(view: mockView, interactor: mockInteractor, person: samplePerson)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testPresenter_LoadPersonDetails_ShouldShowPersonDetails() {
        presenter.loadPersonDetails()
        
        XCTAssertTrue(mockView.didShowPersonDetails, "The presenter should call showPersonDetails on the view.")
        XCTAssertEqual(mockView.personReceived?.name, "Bryan Cranston", "The displayed person's name should be 'Bryan Cranston'.")
    }
    
    func testRouter_NavigatesToPersonDetail() {
        mockRouter.navigateToPersonDetail(person: samplePerson)
        
        XCTAssertTrue(mockRouter.didNavigateToPersonDetail, "The router should navigate to the person's detail view.")
    }
}

class MockPersonDetailView: PersonDetailViewProtocol {
    var personReceived: Person?
    var didShowPersonDetails = false

    func showPersonDetails(_ person: Person) {
        didShowPersonDetails = true
        personReceived = person
    }
}

class MockPersonDetailInteractor: PersonDetailInteractorProtocol {}

class MockPersonDetailRouter: PersonDetailRouterProtocol {
    var didNavigateToPersonDetail = false

    func navigateToPersonDetail(person: Person) {
        didNavigateToPersonDetail = true
    }
}
