//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit
import Kingfisher

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
        TmdbAPIManager.shared.callRequest(type: .movie) { movie in
            self.trendMovieList = movie
            self.trendTableView.reloadData()
        }
    }

}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        cell.genreLabel.text = "\(trendMovieList[indexPath.row].ganre)"
        cell.releaseDateLabel.text = trendMovieList[indexPath.row].releaseDate
        
        let url = URL(string: URL.imageURL+trendMovieList[indexPath.row].posterURL)
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleAspectFill
        
        cell.trendTitleLabel.text = trendMovieList[indexPath.row].movieTitle
        cell.overviewLabel.text = trendMovieList[indexPath.row].overview
        
        return cell
    }
    
}
