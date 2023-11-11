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
        return URL.makeEndPointString("trending/\(self)/day?api_key=\(APIKey.tmdbKey)")

    }
}
