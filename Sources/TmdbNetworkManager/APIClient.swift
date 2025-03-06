//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 05..
//

import Foundation
import Combine

public class APIClient {
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3"
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func fetch(endpoint: APIEndpoint) -> AnyPublisher<Data, URLError> {
        guard let url = getFetchUrl(endpoint: endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    private func getFetchUrl(endpoint: APIEndpoint) -> URL? {
        guard var urlComponents = URLComponents(string: "\(baseURL)\(endpoint.path)") else {
            return nil
        }
        
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = []
        }
        
        urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        
        return urlComponents.url
    }
}

public enum APIEndpoint {
    case popularMovies(page: Int)
    case searchMovies(query: String)
    
    var path: String {
        switch self {
        case .popularMovies(let page):
            return "/movie/popular?page=\(page)"
        case .searchMovies(let query):
            return "/search/movie?query=\(query)"
        }
    }
}
