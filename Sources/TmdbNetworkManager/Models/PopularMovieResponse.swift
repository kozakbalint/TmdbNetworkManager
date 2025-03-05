//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 05..
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int
}
