//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 05..
//

import Foundation

public struct MovieResponse: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
