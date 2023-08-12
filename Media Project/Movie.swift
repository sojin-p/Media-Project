//
//  Movie.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

struct Movie {
    let title: String
    let originalTitle: String
    let releaseDate: String
    let ganre: String
    let overview: String
    let posterURL: String
    
    var movieTitle: String {
        "\(title) (\(originalTitle))"
    }
}
