//
//  Endpoint.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

enum Endpoint {
    case all
    case movie
    case tv
    case person
    
    var requestURL: String {
        switch self {
        case .movie: return URL.makeEndPointString("trending/movie/day?api_key=\(APIKey.tmdbKey)")
        case .all: return URL.makeEndPointString("trending/all/day?api_key=\(APIKey.tmdbKey)")
        case .tv: return URL.makeEndPointString("trending/tv/day?api_key=\(APIKey.tmdbKey)")
        case .person: return URL.makeEndPointString("trending/person/day?api_key=\(APIKey.tmdbKey)")
        }

    }
}
