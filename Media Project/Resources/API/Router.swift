//
//  Router.swift
//  Media Project
//
//  Created by 박소진 on 2023/11/15.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    enum Filter {
        case all
        case movie
        case tv
        
        var string: String {
            return String(describing: self)
        }
    }
    
    case trending(filter: Filter)
    case credits(id: Int)
    case similar(id: Int)
    case videos(id: Int)
    case popular
    case upcoming
    case now_playing
    
    private var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
//    private var baseURLString: String {
//        return "https://api.themoviedb.org/3/"
//    }
    
    private var string: String {
        return String(describing: self)
    }
    
    private var path: String {
        switch self {
        case .trending(let filter):
            return "trending/\(filter.string)/day"
            
        case .credits(let id), .similar(let id), .videos(let id):
            return "movie/\(id)/\(string)"
            
        case .popular, .upcoming, .now_playing:
            return "movie/\(string)"
        }
    }
    
//    var header: HTTPHeaders  {
//        return ["": ""]
//    }
    
    var method: HTTPMethod {
        return .get
    }
    
    private var query: [String: String] {
        return [
            "api_key": APIKey.tmdbKey,
            "language": "ko"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        
        print("url: \(url)")
        
        var request = URLRequest(url: url)
        
//        request.headers = header
        request.method = method
        
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        return request
    }
    
}
