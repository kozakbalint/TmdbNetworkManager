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
    
    public init(adult: Bool, backdropPath: String?, belongsToCollection: BelongsToCollection?, budget: Int, genres: [Genre]?, homepage: String?, id: Int, imdbId: String?, originCountry: [String]?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double, posterPath: String?, productionCompanies: [ProductionCompany]?, productionCountries: [ProductionCountry]?, releaseDate: String?, revenue: Int, runtime: Int, spokenLanguages: [SpokenLanguage]?, status: String?, tagline: String?, title: String?, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    public var posterURL: URL? {
        if posterPath == nil { return nil }
        if posterPath!.isEmpty { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath!)")!
    }
}

public struct BelongsToCollection: Decodable {
    public let id: Int
    public let name, posterPath, backdropPath: String?
    
    public init(id: Int, name: String?, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

public struct Genre: Decodable {
    public let id: Int
    public let name: String?
    
    public init(id: Int, name: String?) {
        self.id = id
        self.name = name
    }
}

public struct ProductionCompany: Decodable {
    public let id: Int
    public let logoPath, name, originCountry: String?
    
    public init(id: Int, logoPath: String?, name: String?, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

public struct ProductionCountry: Decodable {
    public let iso31661, name: String?
    
    public init(iso31661: String?, name: String?) {
        self.iso31661 = iso31661
        self.name = name
    }
}

public struct SpokenLanguage: Decodable {
    public let englishName, iso6391, name: String?
    
    public init(englishName: String?, iso6391: String?, name: String?) {
        self.englishName = englishName
        self.iso6391 = iso6391
        self.name = name
    }
}
