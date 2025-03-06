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
        let expectation = XCTestExpectation(description: "Fetch popular movies")
        
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
    
    func testTopRatedMovies() throws {
        let expectation = XCTestExpectation(description: "Fetch top rated movies")
        
        networkManager.getTopRatedMovies(page: 1)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchMovies() throws {
        let expectation = XCTestExpectation(description: "Search movies")
        
        networkManager.searchMovies(query: "the matrix")
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
    
    func testGetMovieDetails() throws {
        let expectation = XCTestExpectation(description: "Get movie details")
        let movieId = 808
        
        networkManager.getMovieDetails(id: movieId)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            } receiveValue: { movie in
                XCTAssertTrue(movie.id == movieId, "Movie ID should be \(movieId)")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
