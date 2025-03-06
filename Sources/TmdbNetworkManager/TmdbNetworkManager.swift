import Foundation
import Combine

public class TmdbNetworkManager {
    private let apiClient: APIClient
    private let decoder: JSONDecoder
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func getPopularMovies(page: Int = 1) -> AnyPublisher<[MovieResponse], Error> {
        return apiClient.fetch(endpoint: .popularMovies(page: page))
            .decode(type: MoviesResponse.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    public func getTopRatedMovies(page: Int = 1) -> AnyPublisher<[MovieResponse], Error> {
        return apiClient.fetch(endpoint: .topRatedMovies(page: page))
            .decode(type: MoviesResponse.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    public func searchMovies(query: String) -> AnyPublisher<[MovieResponse], Error> {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            let error = URLError(.badURL)
            return Fail(outputType: [MovieResponse].self, failure: error)
                .eraseToAnyPublisher()
        }
        
        return apiClient.fetch(endpoint: .searchMovies(query: encodedQuery))
            .decode(type: MoviesResponse.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, Error> {
        return apiClient.fetch(endpoint: .movieDetails(id: id))
            .decode(type: MovieDetailsResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
