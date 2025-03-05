import Combine
import XCTest
@testable import TmdbNetworkManager

final class TmdbNetworkManagerTests: XCTestCase {
    var networkManager: TmdbNetworkManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        cancellables = []
        
        guard let apiKey = ProcessInfo.processInfo.environment["TMDB_API_KEY"] else {
            XCTFail("No api key set")
            return
        }
        
        let apiClient = APIClient(apiKey: apiKey)
        networkManager = TmdbNetworkManager(apiClient: apiClient)
    }
    
    override func tearDownWithError() throws {
        cancellables = nil
        networkManager = nil
        try super.tearDownWithError()
    }
    
    
    
    func testGetPopularMovies() throws {
        let expectation = XCTestExpectation(description: "Fetch movies")
        
        networkManager.getPopularMovies(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: { movies in
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
