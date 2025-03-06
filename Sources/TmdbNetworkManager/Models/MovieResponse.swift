//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 05..
//

import Foundation

public struct MovieResponse: Decodable, Identifiable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
}
