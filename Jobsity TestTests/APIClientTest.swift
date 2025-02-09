import XCTest
@testable import Jobsity_Test

class APITests: XCTestCase {
    
    var apiClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testFetchSeries_Success() {
        let expectation = self.expectation(description: "Fetch series success")
        
        apiClient.mockFetchSeriesResult = .success([
            Series(id: 1, name: "Breaking Bad", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "21:00", days: ["Sunday"]), genres: ["Drama"], summary: nil),
            Series(id: 2, name: "Stranger Things", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "22:00", days: ["Friday"]), genres: ["Sci-Fi"], summary: nil)
        ])
        
        apiClient.fetchSeries(page: 1) { result in
            switch result {
            case .success(let series):
                XCTAssertEqual(series.count, 2, "There should be 2 series retrieved.")
                XCTAssertEqual(series.first?.name, "Breaking Bad", "The first series should be 'Breaking Bad'.")
            case .failure:
                XCTFail("It should not fail on a valid response.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchSeries_Failure() {
        let expectation = self.expectation(description: "Fetch series failure")
        
        apiClient.mockFetchSeriesResult = .failure(NSError(domain: "APIError", code: 0))
        
        apiClient.fetchSeries(page: 1) { result in
            switch result {
            case .success:
                XCTFail("It should not have returned a successful response.")
            case .failure:
                XCTAssertTrue(true, "The error should be handled correctly.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchSeries_Success() {
        let expectation = self.expectation(description: "Search series success")
        
        apiClient.mockSearchSeriesResult = .success([
            Series(id: 1, name: "Breaking Bad", image: Series.Image(medium: "https://example.com/image.jpg", original: "https://example.com/image.jpg"), schedule: Series.Schedule(time: "21:00", days: ["Sunday"]), genres: ["Drama"], summary: nil)
        ])
        
        apiClient.searchSeries(query: "Breaking Bad") { result in
            switch result {
            case .success(let series):
                XCTAssertEqual(series.first?.name, "Breaking Bad", "The series found should be 'Breaking Bad'.")
            case .failure:
                XCTFail("It should not fail on a valid response.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchSeries_Failure() {
        let expectation = self.expectation(description: "Search series failure")
        
        apiClient.mockSearchSeriesResult = .failure(NSError(domain: "SearchError", code: 0))
        
        apiClient.searchSeries(query: "Nonexistent Show") { result in
            switch result {
            case .success:
                XCTFail("It should not have returned a successful response.")
            case .failure:
                XCTAssertTrue(true, "The error should be handled correctly.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchEpisodes_Success() {
        let expectation = self.expectation(description: "Fetch episodes success")
        
        apiClient.mockFetchEpisodesResult = .success([
            Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: "First episode of the series.", image: nil)
        ])
        
        apiClient.fetchEpisodes(for: 1) { result in
            switch result {
            case .success(let episodes):
                XCTAssertEqual(episodes.first?.name, "Pilot", "The episode should be named 'Pilot'.")
            case .failure:
                XCTFail("It should not fail on a valid response.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchEpisodes_Failure() {
        let expectation = self.expectation(description: "Fetch episodes failure")
        
        apiClient.mockFetchEpisodesResult = .failure(NSError(domain: "APIError", code: 0))
        
        apiClient.fetchEpisodes(for: 1) { result in
            switch result {
            case .success:
                XCTFail("It should not have returned a successful response.")
            case .failure:
                XCTAssertTrue(true, "The error should be handled correctly.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchPeople_Success() {
        let expectation = self.expectation(description: "Search people success")
        
        apiClient.mockSearchPeopleResult = .success([
            Person(id: 1, name: "Bryan Cranston", image: nil)
        ])
        
        apiClient.searchPeople(query: "Bryan Cranston") { result in
            switch result {
            case .success(let people):
                XCTAssertEqual(people.first?.name, "Bryan Cranston", "The person found should be 'Bryan Cranston'.")
            case .failure:
                XCTFail("It should not fail on a valid response.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

class MockAPIClient: APIService {
    var mockFetchSeriesResult: Result<[Series], Error>?
    var mockSearchSeriesResult: Result<[Series], Error>?
    var mockFetchEpisodesResult: Result<[Episode], Error>?
    var mockSearchPeopleResult: Result<[Person], Error>?
    
    func fetchSeries(page: Int, completion: @escaping (Result<[Series], Error>) -> Void) {
        if let result = mockFetchSeriesResult {
            completion(result)
        }
    }
    
    func searchSeries(query: String, completion: @escaping (Result<[Series], Error>) -> Void) {
        if let result = mockSearchSeriesResult {
            completion(result)
        }
    }
    
    func fetchEpisodes(for seriesId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        if let result = mockFetchEpisodesResult {
            completion(result)
        }
    }
    
    func searchPeople(query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        if let result = mockSearchPeopleResult {
            completion(result)
        }
    }
}
