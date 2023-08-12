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
    let ganre: Int //배열, 장르리스트가 따로 있음
    let overview: String
    let prosterURL: String
    
    var movieTitle: String {
        "\(title) (\(originalTitle))"
    }
}
