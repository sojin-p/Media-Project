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
        var movie: [Movie] = []
        
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
                    
                    let posterURL = URL.imageURL+item["poster_path"].stringValue
                    let backdropURL = URL.imageURL+item["backdrop_path"].stringValue
                    
                    let data = Movie(id: id, title: title, originalTitle: originalTitle, releaseDate: releaseDate, genre: genre, overview: overview, posterURL: posterURL, backdropURL: backdropURL)
                    
                    movie.append(data)
                }
                
                completionHandler(movie)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callCreditRequest(id: Int, completionHandler: @escaping ([Cast]) -> () ) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.tmdbKey)")
        var cast: [Cast] = []
        
        AF.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in json["cast"].arrayValue {
                    let name = i["original_name"].stringValue
                    let character = i["character"].stringValue
                    let profile = URL.imageURL+i["profile_path"].stringValue
                    
                    let data = Cast(originalName: name, character: character, profileURLString: profile)
                    cast.append(data)
                }
                completionHandler(cast)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
