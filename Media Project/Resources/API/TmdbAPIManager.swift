//
//  TmdbAPIManager.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Int, Error, LocalizedError {
    case unathorized = 401
    case permisstionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unathorized:
            return "인증 정보가 없습니다."
        case .permisstionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
}

class TmdbAPIManager {
    
    static let shared = TmdbAPIManager()
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, comletion: @escaping (Result<T, NetworkError>) -> () ) {
        
        AF.request(api).validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data): comletion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    print("==statusCode==",statusCode)
                    guard let error = NetworkError(rawValue: statusCode) else { return }
                    comletion(.failure(error))
                }
            }
    }
    
    let parameters: Parameters = ["language": "ko"]

    func callRequest(type: Endpoint, page: Int, completionHandler: @escaping (AllTrend?) -> Void ) {

        guard let url = URL(string: type.requestURL + "&page=\(page)&language=ko" ) else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {

                if let error {
                    completionHandler(nil)
                    print(error)
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    print(error)
                    return
                }

                guard let data = data else {
                    completionHandler(nil)
                    return
                }

                do {
                    let result = try JSONDecoder().decode(AllTrend.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                    print(error)
                }
            }

        }.resume()
        
//        let url = type.requestURL + "&page=\(page)"
//        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...500)
//            .responseDecodable(of: MovieTrend.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }

//    func callCreditRequest(id: Int, completionHandler: @escaping ([Cast]) -> () ) {
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.tmdbKey)")
//        var cast: [Cast] = []
//
//        AF.request(url!, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
////                print("JSON: \(json)")
//
//                for i in json["cast"].arrayValue {
//                    let name = i["original_name"].stringValue
//                    let character = i["character"].stringValue
//                    let profile = URL.imageURL+i["profile_path"].stringValue
//
//                    let data = Cast(originalName: name, character: character, profileURLString: profile)
//                    cast.append(data)
//                }
//                completionHandler(cast)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

    func callSimilarRequset(id: Int, completionHandler: @escaping (MovieTrend) -> () ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...500)
            .responseDecodable(of: MovieTrend.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callVideoRequset(id: Int, completionHandler: @escaping (MovieVideoData) -> () ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...500)
            .responseDecodable(of: MovieVideoData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
