import Foundation
import Combine

public class TmdbNetworkManager {
    private let apiClient: APIClient
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    public func getPopularMovies(page: Int = 1) -> AnyPublisher<[MovieResponse], Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return apiClient.fetch(endpoint: .movies(page: page))
            .decode(type: PopularMoviesResponse.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
