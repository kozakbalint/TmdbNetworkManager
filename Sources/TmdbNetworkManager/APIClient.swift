//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 05..
//

import Foundation
import Combine

public class APIClient {
    private let authToken: String
    private let baseURL = "https://api.themoviedb.org/3"
    
    public init(authToken: String) {
        self.authToken = authToken
    }
    
    public func fetch(endpoint: APIEndpoint) -> AnyPublisher<Data, URLError> {
        guard let url = getFetchUrl(endpoint: endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    public func post(endpoint: APIEndpoint, parameters: [String: Any]) -> AnyPublisher<Data, Error> {
        guard let url = getFetchUrl(endpoint: endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return Fail(error: URLError(.cannotParseResponse)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    private func getFetchUrl(endpoint: APIEndpoint) -> URL? {
        guard let urlComponents = URLComponents(string: "\(baseURL)\(endpoint.path)") else {
            return nil
        }
        
        return urlComponents.url
    }
}

public enum APIEndpoint {
    case popularMovies(page: Int)
    case topRatedMovies(page: Int)
    case searchMovies(query: String)
    case movieDetails(id: Int)
    case addRatingToMovie(id: Int)
    
    var path: String {
        switch self {
        case .popularMovies(let page):
            return "/movie/popular?page=\(page)"
        case .topRatedMovies(let page):
            return "/movie/top_rated?page=\(page)"
        case .searchMovies(let query):
            return "/search/movie?query=\(query)"
        case .movieDetails(id: let id):
            return "/movie/\(id)"
        case .addRatingToMovie(let id):
            return "/movie/\(id)/rating"
        }
    }
}
