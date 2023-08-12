//
//  Movie.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    let originalTitle: String
    
    let releaseDate: String
    let genre: String
    let overview: String
    
    let posterURL: String
    let backdropURL: String
    
    var movieTitle: String {
        "\(title) (\(originalTitle))"
    }
}
