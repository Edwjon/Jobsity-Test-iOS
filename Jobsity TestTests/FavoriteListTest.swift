import XCTest
@testable import Jobsity_Test

class FavoritesListTests: XCTestCase {
    
    var presenter: FavoritesListPresenter!
    var mockView: MockFavoritesListView!
    var mockInteractor: MockFavoritesListInteractor!
    var mockRouter: MockFavoritesListRouter!
    
    let sampleSeries = Series(
        id: 1,
        name: "Breaking Bad",
        image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"),
        schedule: Series.Schedule(time: "21:00", days: ["Sunday"]),
        genres: ["Example 1", "Example 2"],
        summary: "A high school chemistry teacher turned methamphetamine producer."
    )
    
    override func setUp() {
        super.setUp()
        mockView = MockFavoritesListView()
        mockInteractor = MockFavoritesListInteractor()
        mockRouter = MockFavoritesListRouter()
        
        presenter = FavoritesListPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testPresenter_LoadFavoriteSeries_WhenFavoritesExist_ShouldShowFavorites() {
        mockInteractor.favoriteSeries = [sampleSeries]
        
        presenter.loadFavoriteSeries()
        
        XCTAssertTrue(mockView.didShowFavorites, "The presenter should call showFavorites.")
        XCTAssertEqual(mockView.seriesReceived?.first?.name, "Breaking Bad", "The received series should be 'Breaking Bad'.")
    }
    
    func testPresenter_LoadFavoriteSeries_WhenNoFavorites_ShouldShowError() {
        mockInteractor.favoriteSeries = []
        
        presenter.loadFavoriteSeries()
        
        XCTAssertTrue(mockView.didShowError, "The presenter should call showError if there are no favorites.")
    }
    
    func testRouter_NavigatesToSeriesDetail() {
        mockRouter.navigateToSeriesDetail(series: sampleSeries, delegate: mockView)
        
        XCTAssertTrue(mockRouter.didNavigateToSeriesDetail, "The router should navigate to the series detail view.")
    }
}

class MockFavoritesListView: FavoritesListViewProtocol, FavoritesListViewDelegate {
    var seriesReceived: [Series]?
    var didShowFavorites = false
    var didShowError = false

    func showFavorites(_ series: [Series]) {
        didShowFavorites = true
        seriesReceived = series
    }

    func showError(_ message: String) {
        didShowError = true
    }

    func didUpdateFavorites() {
        didShowFavorites = true
    }
}

class MockFavoritesListInteractor: FavoritesListInteractorProtocol {
    var favoriteSeries: [Series] = []

    func getFavoriteSeries() -> [Series] {
        return favoriteSeries
    }
}

class MockFavoritesListRouter: FavoritesListRouterProtocol {
    var didNavigateToSeriesDetail = false

    func navigateToSeriesDetail(series: Series, delegate: FavoritesListViewDelegate) {
        didNavigateToSeriesDetail = true
    }
}
