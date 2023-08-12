//
//  DetailViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    let sectionTitleList = ["OverView", "Cast"]
    var isClicked: Bool = false
    var movie: Movie?
    var cast: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie else { return }
        
        titleLabel.text = movie.movieTitle
        
        let backdrop = URL(string: URL.imageURL + movie.backdropURL)
        let poster = URL(string: URL.imageURL + movie.posterURL)
        backdropImageView.kf.setImage(with: backdrop)
        posterImageView.kf.setImage(with: poster)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        let detailNib = UINib(nibName: DetailTableViewCell.identifier, bundle: nil)
        detailTableView.register(detailNib, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        let castNib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        detailTableView.register(castNib, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        callRequest(id: movie.id)

    }
    
    func callRequest(id: Int) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.tmdbKey)")
        AF.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in json["cast"].arrayValue {
                    let name = i["original_name"].stringValue
                    let character = i["character"].stringValue
                    let profile = i["profile_path"].stringValue
                    
                    let data = Cast(originalName: name, character: character, profileURLString: profile)
                    self.cast.append(data)
                }
                self.detailTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return cast.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else { return UITableViewCell() }
            
            detailCell.overviewTextView.text = movie?.overview
            
            return detailCell
            
        case 1:
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            DispatchQueue.main.async {
                castCell.castTitleLabel.text = self.cast[indexPath.row].castTitle
                
                let profile = URL(string: URL.imageURL + self.cast[indexPath.row].profileURLString)
                castCell.castImageView.kf.setImage(with: profile)
                castCell.castImageView.contentMode = .scaleAspectFill
            }
            
            return castCell
            
        default:
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0, isClicked {
            return 300 //유동적으로..
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            isClicked.toggle()
        }
        tableView.reloadData()
        
    }
}
