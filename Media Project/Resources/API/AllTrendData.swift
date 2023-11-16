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
    var results: [AllResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct AllResult: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String?
    let originalName: String?
    let overview, posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let firstAirDate: String?
    let title, originalTitle, releaseDate: String?
    let video: Bool?
    let profilePath: String?
//    let gender: Int?
//    let knownForDepartment: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case firstAirDate = "first_air_date"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video
        case profilePath = "profile_path"
//        case knownForDepartment = "known_for_department"

    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case all = "all"
    case person = "person"
}
