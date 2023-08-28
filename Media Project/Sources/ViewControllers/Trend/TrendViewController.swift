//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit

class TrendViewController: BaseViewController {

    @IBOutlet var trendTableView: UITableView!
    
    let genres = [ 28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime",
                    99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History",
                    27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction",
                    10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"
    ]
    var trendList: [Result] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(page: page)
        
    }
    
    func callRequest(page: Int) {
        TmdbAPIManager.shared.callRequest(type: .movie, page: page) { movie in
            self.trendList.append(contentsOf: movie.results)
            self.trendTableView.reloadData()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        title = "타이틀"

        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.prefetchDataSource = self
        trendTableView.estimatedRowHeight = 350
        trendTableView.rowHeight = UITableView.automaticDimension

        let nib = UINib(nibName: TrendTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }

}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        if let genre = genres[trendList[indexPath.row].genreIDS[0]] {
            cell.genreLabel.text = "#\(genre)"
        }
        
        cell.releaseDateLabel.text = trendList[indexPath.row].releaseDate

        let url = URL(string: URL.imageURL + (trendList[indexPath.row].backdropPath ?? ""))
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleAspectFill
        
        cell.trendTitleLabel.text = trendList[indexPath.row].title
        cell.originalTitleLabel.text = trendList[indexPath.row].originalTitle
        cell.overviewLabel.text = trendList[indexPath.row].overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MainSB = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = MainSB.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        detailVC.movie = trendList[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
}

extension TrendViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if trendList.count - 1 == indexPath.row && page < 5 {
                page += 1
                callRequest(page: page)
            }
        }
    }
    
}
