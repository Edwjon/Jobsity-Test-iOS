import XCTest
@testable import Jobsity_Test

class FavoritesManagerTests: XCTestCase {
    
    var favoritesManager: FavoritesManager!
    let testSeries = Series(id: 1, name: "Breaking Bad", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "21:00", days: ["Sunday"]), genres: ["Drama"], summary: nil)

    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager.shared
        UserDefaults.standard.removeObject(forKey: "favorite_series")
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "favorite_series")
        favoritesManager = nil
        super.tearDown()
    }
    
    func testAddFavorite_ShouldSaveSeries() {
        favoritesManager.addFavorite(series: testSeries)
        
        let favorites = favoritesManager.getAllFavorites()
        XCTAssertTrue(favorites.contains { $0.id == testSeries.id }, "The series should be in the favorites list.")
    }
    
    func testAddFavorite_DuplicateSeries_ShouldNotDuplicate() {
        favoritesManager.addFavorite(series: testSeries)
        favoritesManager.addFavorite(series: testSeries)
        
        let favorites = favoritesManager.getAllFavorites()
        XCTAssertEqual(favorites.count, 1, "There should be no duplicates in the favorites list.")
    }
    
    func testRemoveFavorite_ShouldRemoveSeries() {
        favoritesManager.addFavorite(series: testSeries)
        favoritesManager.removeFavorite(seriesId: testSeries.id)
        
        let favorites = favoritesManager.getAllFavorites()
        XCTAssertFalse(favorites.contains { $0.id == testSeries.id }, "The series should have been removed from favorites.")
    }
    
    func testIsFavorite_ShouldReturnCorrectValue() {
        favoritesManager.addFavorite(series: testSeries)
        XCTAssertTrue(favoritesManager.isFavorite(seriesId: testSeries.id), "It should return 'true' if the series is in favorites.")
        
        favoritesManager.removeFavorite(seriesId: testSeries.id)
        XCTAssertFalse(favoritesManager.isFavorite(seriesId: testSeries.id), "It should return 'false' if the series is not in favorites.")
    }
    
    func testGetAllFavorites_EmptyList_ShouldReturnEmpty() {
        let favorites = favoritesManager.getAllFavorites()
        XCTAssertEqual(favorites.count, 0, "The favorites list should be empty initially.")
    }
}
