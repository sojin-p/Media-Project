//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit
import Alamofire
import SwiftyJSON

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!
    
    var trendMovieList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "타이틀"
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.estimatedRowHeight = 380
        trendTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendTableViewCell.identifier)
        
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIKey.tmbdKey)"
        let parameters: Parameters = ["language": "ko"]
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
                    
                    print(data,"---------")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
