//
//  TmdbAPIManager.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class TmdbAPIManager {
    
    static let shared = TmdbAPIManager()
    private init() { }
    
    var genreCode: [Int: String] = [:]
    
    func callGenre(type: Endpoint) {
        
        let url = type.requestURL
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for i in json["genres"].arrayValue {
                    let id = i["id"].intValue
                    let genre = i["name"].stringValue
                    self.genreCode[id] = genre
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequest(type: Endpoint, completionHandler: @escaping ([Movie]) -> () ) {
        
        callGenre(type: .movieGenre)
        
        let url = type.requestURL
        let parameters: Parameters = ["language": "ko"]
        var test: [Movie] = []
        
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    
                    let id = item["id"].intValue
                    let title = item["title"].stringValue
                    let originalTitle = item["original_title"].stringValue
                    
                    let releaseDate = item["release_date"].stringValue
                    let genre1 = item["genre_ids"][0].intValue
                    guard let genre = self.genreCode[genre1] else { return }
                    let overview = item["overview"].stringValue
                    
                    let posterURL = item["poster_path"].stringValue
                    let backdropURL = item["backdrop_path"].stringValue
                    
                    let data = Movie(id: id, title: title, originalTitle: originalTitle, releaseDate: releaseDate, genre: genre, overview: overview, posterURL: posterURL, backdropURL: backdropURL)
                    
                    test.append(data)
                }
                
                completionHandler(test)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
