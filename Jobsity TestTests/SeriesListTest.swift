import XCTest
@testable import Jobsity_Test

class SeriesListTests: XCTestCase {
    
    var presenter: SeriesListPresenter!
    var mockView: MockSeriesListView!
    var mockInteractor: MockSeriesListInteractor!
    var mockRouter: MockSeriesListRouter!
    var testSeries: [Series]!

    override func setUp() {
        super.setUp()
        mockView = MockSeriesListView()
        mockInteractor = MockSeriesListInteractor()
        mockRouter = MockSeriesListRouter()
        
        testSeries = [
            Series(id: 1, name: "Breaking Bad", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "21:00", days: ["Sunday"]), genres: ["Drama"], summary: nil),
            Series(id: 2, name: "Stranger Things", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "22:00", days: ["Friday"]), genres: ["Sci-Fi"], summary: nil)
        ]
        
        presenter = SeriesListPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        testSeries = nil
        super.tearDown()
    }

    // ✅ Test: Cargar series correctamente
    func testLoadMoreSeries_ShouldShowSeriesOnSuccess() {
        mockInteractor.mockSeriesResult = .success(testSeries)
        
        presenter.loadMoreSeries()
        
        XCTAssertTrue(mockView.didShowSeries, "Debería llamar a showSeries en la vista.")
        XCTAssertEqual(mockView.series?.count, testSeries.count, "La cantidad de series mostradas debería ser la misma que la de prueba.")
    }

    // ❌ Test: Error al cargar series
    func testLoadMoreSeries_ShouldShowErrorOnFailure() {
        mockInteractor.mockSeriesResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        
        presenter.loadMoreSeries()
        
        XCTAssertTrue(mockView.didShowError, "Debería mostrar un error en la vista si la carga de series falla.")
    }

    // 🔎 Test: Buscar series con éxito
    func testSearchSeries_ShouldShowResultsOnSuccess() {
        mockInteractor.mockSearchResult = .success(testSeries)
        
        presenter.searchSeries(query: "Breaking Bad")
        
        XCTAssertTrue(mockView.didShowSeries, "Debería llamar a showSeries en la vista con los resultados de la búsqueda.")
        XCTAssertEqual(mockView.series?.first?.name, "Breaking Bad", "El primer resultado de búsqueda debería ser 'Breaking Bad'.")
    }

    // ❌ Test: Error al buscar series
    func testSearchSeries_ShouldShowErrorOnFailure() {
        mockInteractor.mockSearchResult = .failure(NSError(domain: "SearchError", code: 0, userInfo: nil))
        
        presenter.searchSeries(query: "Nonexistent Show")
        
        XCTAssertTrue(mockView.didShowError, "Debería mostrar un error en la vista si la búsqueda falla.")
    }

    // 🏆 Test: Navegación a detalles de la serie
    func testShowSeriesDetails_ShouldNavigateToSeriesDetail() {
        presenter.showSeriesDetails(testSeries.first!)
        
        XCTAssertTrue(mockRouter.didNavigateToSeriesDetail, "Debería navegar a la pantalla de detalles de la serie.")
    }

    // ⭐ Test: Navegación a favoritos
    func testShowFavorites_ShouldNavigateToFavorites() {
        presenter.showFavorites()
        
        XCTAssertTrue(mockRouter.didNavigateToFavorites, "Debería navegar a la lista de favoritos.")
    }

    // 🧑‍🤝‍🧑 Test: Navegación a búsqueda de personas
    func testShowPeopleSearch_ShouldNavigateToPeopleSearch() {
        presenter.showPeopleSearch()
        
        XCTAssertTrue(mockRouter.didNavigateToPeopleSearch, "Debería navegar a la búsqueda de personas.")
    }
}

// ✅ Mock de la vista
class MockSeriesListView: SeriesListViewProtocol {
    var didShowSeries = false
    var series: [Series]?
    var didShowError = false

    func showSeries(_ series: [Series]) {
        didShowSeries = true
        self.series = series
    }

    func showError(_ message: String) {
        didShowError = true
    }
}

// ✅ Mock del interactor
class MockSeriesListInteractor: SeriesListInteractorProtocol {
    var mockSeriesResult: Result<[Series], Error>?
    var mockSearchResult: Result<[Series], Error>?

    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void) {
        if let result = mockSeriesResult {
            completion(result)
        }
    }
    
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void) {
        if let result = mockSearchResult {
            completion(result)
        }
    }
    
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {}
}

// ✅ Mock del router
class MockSeriesListRouter: SeriesListRouterProtocol {
    var didNavigateToSeriesDetail = false
    var didNavigateToFavorites = false
    var didNavigateToPeopleSearch = false

    func navigateToSeriesDetail(series: Series) {
        didNavigateToSeriesDetail = true
    }
    
    func navigateToFavorites() {
        didNavigateToFavorites = true
    }
    
    func navigateToPeopleSearch() {
        didNavigateToPeopleSearch = true
    }
}
