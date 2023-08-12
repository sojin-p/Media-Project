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
    
    func callRequest(type: Endpoint, completionHandler: @escaping ([Movie]) -> () ) {
        
        let url = type.requestURL
        let parameters: Parameters = ["language": "ko"]
        var test: [Movie] = []
        
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let title = item["title"].stringValue
                    let originalTitle = item["original_title"].stringValue
                    let releaseDate = item["release_date"].stringValue
                    let ganre = item["genre_ids"].intValue
                    let overview = item["overview"].stringValue
                    let prosterURL = item["poster_path"].stringValue
                    
                    let data = Movie(title: title, originalTitle: originalTitle, releaseDate: releaseDate, ganre: ganre, overview: overview, prosterURL: prosterURL)
                    
                    test.append(data)
                }
                
                completionHandler(test)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
}
