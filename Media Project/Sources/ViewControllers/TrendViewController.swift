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
        
        setUI()
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
        
        cell.genreLabel.text = "#\(trendMovieList[indexPath.row].genre)"
        cell.releaseDateLabel.text = trendMovieList[indexPath.row].releaseDate
        
        let url = URL(string: trendMovieList[indexPath.row].backdropURL)
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleAspectFill
        
        cell.trendTitleLabel.text = trendMovieList[indexPath.row].movieTitle
        cell.overviewLabel.text = trendMovieList[indexPath.row].overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MainSB = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = MainSB.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        let nav = UINavigationController(rootViewController: detailVC)
        
        detailVC.movie = trendMovieList[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        navigationController?.pushViewController(detailVC, animated: true)
        trendTableView.reloadData()
    }
    
}

extension TrendViewController {
    
    func setUI() {
        title = "타이틀"
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.estimatedRowHeight = 380
        trendTableView.rowHeight = UITableView.automaticDimension
        
        trendTableView.separatorColor = .clear
        
        setNib()
    }
    
    func setNib() {
        let nib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
}
