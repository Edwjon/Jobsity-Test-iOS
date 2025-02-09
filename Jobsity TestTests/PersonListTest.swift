import XCTest
@testable import Jobsity_Test

class PeopleSearchTests: XCTestCase {
    
    var presenter: PeopleSearchPresenter!
    var mockView: MockPeopleSearchView!
    var mockInteractor: MockPeopleSearchInteractor!
    var mockRouter: MockPeopleSearchRouter!
    
    let samplePerson = Person(
        id: 1,
        name: "Bryan Cranston",
        image: Image(medium: "https://example.com/image.jpg", original: nil)
    )
    
    override func setUp() {
        super.setUp()
        mockView = MockPeopleSearchView()
        mockInteractor = MockPeopleSearchInteractor()
        mockRouter = MockPeopleSearchRouter()
        
        presenter = PeopleSearchPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testRouter_NavigatesToPersonDetail() {
        mockRouter.navigateToPersonDetail(person: samplePerson)
        
        XCTAssertTrue(mockRouter.didNavigateToPersonDetail, "The router should navigate to the person's detail view.")
    }
}

class MockPeopleSearchView: PeopleSearchViewProtocol {
    var peopleReceived: [Person]?
    var didShowPeople = false
    var didShowError = false

    func showPeople(_ people: [Person]) {
        didShowPeople = true
        peopleReceived = people
    }

    func showError(_ message: String) {
        didShowError = true
    }
}

class MockPeopleSearchInteractor: PeopleSearchInteractorProtocol {
    var shouldReturnPeople = true

    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        if shouldReturnPeople {
            let samplePerson = Person(
                id: 1,
                name: "Bryan Cranston",
                image: Image(medium: "https://example.com/image.jpg", original: nil)
            )
            completion(.success([samplePerson]))
        } else {
            completion(.failure(NSError(domain: "TestError", code: -1, userInfo: nil)))
        }
    }
}

class MockPeopleSearchRouter: PeopleSearchRouterProtocol {
    var didNavigateToPersonDetail = false

    func navigateToPersonDetail(person: Person) {
        didNavigateToPersonDetail = true
    }
}
