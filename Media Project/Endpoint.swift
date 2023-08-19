//
//  Endpoint.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

enum Endpoint {
    case movie
    
    var requestURL: String {
        switch self {
        case .movie: return URL.makeEndPointString("trending/movie/day?api_key=\(APIKey.tmdbKey)")
        }
    }
}
