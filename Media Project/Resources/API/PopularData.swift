//
//  PopularData.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/16.
//

import Foundation

struct PopularData: Decodable {
    let page: Int
    let results: [PopularResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PopularResult: Decodable {
    let title: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let posterPath, backdropPath: String?
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title, id, video, overview
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
