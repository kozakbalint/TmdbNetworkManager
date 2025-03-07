//
//  File.swift
//  TmdbNetworkManager
//
//  Created by Balint Kozak on 2025. 03. 07..
//

import Foundation

public struct RatingResponse: Codable {
    public let success: Bool
    public let statusCode: Int
    public let statusMessage: String
}
