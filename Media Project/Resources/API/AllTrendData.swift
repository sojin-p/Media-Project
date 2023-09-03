//
//  AllTrendData.swift
//  Media Project
//
//  Created by 박소진 on 2023/09/03.
//

import Foundation

// MARK: - SearchPhoto
struct AllTrend: Codable {
    let page: Int
    var results: [TrendResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TrendResult: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String?
    let originalName: String?
    let overview, posterPath: String
    let mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]?
    let title, originalTitle, releaseDate: String?
    let video: Bool?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video
        case profilePath = "profile_path"
    }
}
