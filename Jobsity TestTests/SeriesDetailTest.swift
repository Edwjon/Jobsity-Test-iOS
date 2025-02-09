import XCTest
@testable import Jobsity_Test

class SeriesDetailTests: XCTestCase {
    
    var presenter: SeriesDetailPresenter!
    var mockView: MockSeriesDetailView!
    var mockInteractor: MockSeriesDetailInteractor!
    var mockRouter: MockSeriesDetailRouter!
    var testSeries: Series!

    override func setUp() {
        super.setUp()
        mockView = MockSeriesDetailView()
        mockInteractor = MockSeriesDetailInteractor()
        mockRouter = MockSeriesDetailRouter()
        
        testSeries = Series(id: 1, name: "Breaking Bad", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "21:00", days: ["Sunday"]), genres: ["Drama"], summary: nil)
        
        presenter = SeriesDetailPresenter(view: mockView, interactor: mockInteractor, series: testSeries)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        testSeries = nil
        super.tearDown()
    }

    func testLoadEpisodes_ShouldShowEpisodesOnSuccess() {
        let testEpisodes = [
            Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: "Walter White starts his meth empire.", image: nil),
            Episode(id: 2, name: "Cat's in the Bag", season: 1, number: 2, summary: "Walter and Jesse clean up a mess.", image: nil)
        ]
        mockInteractor.mockEpisodesResult = .success(testEpisodes)
        
        presenter.loadEpisodes()
        
        XCTAssertTrue(mockView.didShowEpisodes, "It should call showEpisodes on the view.")
        XCTAssertEqual(mockView.episodes?.count, testEpisodes.count, "The number of episodes displayed should match the test data.")
    }

    func testLoadEpisodes_ShouldShowErrorOnFailure() {
        mockInteractor.mockEpisodesResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        
        presenter.loadEpisodes()
        
        XCTAssertTrue(mockView.didShowError, "It should display an error in the view if episode loading fails.")
    }
}

class MockSeriesDetailView: SeriesDetailViewProtocol {
    var didShowEpisodes = false
    var episodes: [Episode]?
    var didShowError = false

    func showEpisodes(_ episodes: [Episode]) {
        didShowEpisodes = true
        self.episodes = episodes
    }

    func showError(_ message: String) {
        didShowError = true
    }
}

class MockSeriesDetailInteractor: SeriesDetailInteractorProtocol {
    var mockEpisodesResult: Result<[Episode], Error>?

    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        if let result = mockEpisodesResult {
            completion(result)
        }
    }
}

class MockSeriesDetailRouter: SeriesDetailRouterProtocol {
    var didNavigateToEpisodeDetail = false

    func navigateToEpisodeDetail(episode: Episode) {
        didNavigateToEpisodeDetail = true
    }
}
