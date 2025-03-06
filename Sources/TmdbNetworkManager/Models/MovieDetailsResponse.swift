//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 06..
//

import Foundation

public struct MovieDetailsResponse: Decodable, Identifiable {
    public let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int
    public let genres: [Genre]?
    public let homepage: String?
    public let id: Int
    public let imdbId: String?
    public let originCountry: [String]?
    public let originalLanguage, originalTitle, overview: String?
    public let popularity: Double
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue, runtime: Int
    public let spokenLanguages: [SpokenLanguage]?
    public let status, tagline, title: String?
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
}

public struct BelongsToCollection: Decodable {
    public let id: Int
    public let name, posterPath, backdropPath: String?
}

public struct Genre: Decodable {
    public let id: Int
    public let name: String?
}

public struct ProductionCompany: Decodable {
    public let id: Int
    public let logoPath, name, originCountry: String?
}

public struct ProductionCountry: Decodable {
    public let iso31661, name: String?
}

public struct SpokenLanguage: Decodable {
    public let englishName, iso6391, name: String?
}
