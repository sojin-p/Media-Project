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
    var page = 1
    var stop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        callRequest(page: page)
        
    }
    
    func callRequest(page: Int) {
        TmdbAPIManager.shared.callRequest(type: .movie, page: page) { movie in
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
        
        detailVC.movie = trendMovieList[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
}

extension TrendViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if trendMovieList.count - 1 == indexPath.row && page < 3 {
                page += 1
                callRequest(page: page)
            }
        }
    }
    
}

extension TrendViewController {
    
    func setUI() {
        title = "타이틀"
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.prefetchDataSource = self
        trendTableView.estimatedRowHeight = 350
        trendTableView.rowHeight = UITableView.automaticDimension
        
        trendTableView.separatorColor = .clear
        
        setNib()
    }
    
    func setNib() {
        let nib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
}
