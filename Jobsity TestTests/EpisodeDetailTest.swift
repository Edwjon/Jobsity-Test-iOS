import XCTest
@testable import Jobsity_Test

class EpisodeDetailTests: XCTestCase {
    
    var presenter: EpisodeDetailPresenter!
    var mockView: MockEpisodeDetailView!
    var mockInteractor: MockEpisodeDetailInteractor!
    var mockRouter: MockEpisodeDetailRouter!
    
    let sampleEpisode = Episode(
        id: 1,
        name: "Test Episode",
        season: 1,
        number: 1,
        summary: "This is a test episode.",
        image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg")
    )
    
    override func setUp() {
        super.setUp()
        mockView = MockEpisodeDetailView()
        mockInteractor = MockEpisodeDetailInteractor()
        mockRouter = MockEpisodeDetailRouter()
        
        presenter = EpisodeDetailPresenter(view: mockView, interactor: mockInteractor, episode: sampleEpisode)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testPresenter_LoadsEpisodeDetails() {
        presenter.loadEpisodeDetails()
        
        XCTAssertTrue(mockView.didShowEpisodeDetails, "The presenter should call showEpisodeDetails.")
        XCTAssertEqual(mockView.episodeReceived?.name, "Test Episode", "The received episode should be correct.")
    }
    
    func testRouter_NavigatesToEpisodeDetail() {
        mockRouter.navigateToEpisodeDetail(episode: sampleEpisode)
        
        XCTAssertTrue(mockRouter.didNavigateToEpisodeDetail, "The router should navigate to the episode detail view.")
    }
}

class MockEpisodeDetailView: EpisodeDetailViewProtocol {
    var episodeReceived: Episode?
    var didShowEpisodeDetails = false

    func showEpisodeDetails(_ episode: Episode) {
        didShowEpisodeDetails = true
        episodeReceived = episode
    }
}

class MockEpisodeDetailInteractor: EpisodeDetailInteractorProtocol {
    func fetchEpisodeDetails() {}
}

class MockEpisodeDetailRouter: EpisodeDetailRouterProtocol {
    var didNavigateToEpisodeDetail = false

    func navigateToEpisodeDetail(episode: Episode) {
        didNavigateToEpisodeDetail = true
    }
}
