//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit

class TrendViewController: BaseViewController {

    let mainView = TrendView()
    var page = 1
    var trendList: AllTrend = AllTrend(page: 0, results: [], totalPages: 0, totalResults: 0)
    var mediaType: MediaType = .all
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mediaType == .movie {
            callRequest(page: page, type: .movie)
        } else if mediaType == .tv {
            callRequest(page: page, type: .tv)
        } else if mediaType == .all {
            callRequest(page: page, type: .all)
        } else {
            callRequest(page: page, type: .person)
        }
        
    }
    
    func callRequest(page: Int, type: Endpoint) {
        TmdbAPIManager.shared.callRequest(type: type, page: page) { data in
            guard let data = data else {
                print("얼럿띄우기")
                return
            }
            self.trendList.results.append(contentsOf: data.results)
            self.mainView.tableView.reloadData()
        }
    }
    
    func setPopUpButton() {
        let menuClosure = { [weak self] (action: UIAction) in
            print("클릭 \(action.title)")
            self?.trendList.results.removeAll()
            
            if action.title == "Movie" {
                self?.mediaType = .movie
                self?.callRequest(page: 1, type: .movie)
            } else if action.title == "TV" {
                self?.mediaType = .tv
                self?.callRequest(page: 1, type: .tv)
            } else if action.title == "All" {
                self?.mediaType = .all
                self?.callRequest(page: 1, type: .all)
            } else {
                self?.mediaType = .person
                self?.callRequest(page: 1, type: .person)
            }
        }
        
        let menu = UIMenu(children: [
            UIAction(title: "All", handler: menuClosure),
            UIAction(title: "Movie", handler: menuClosure),
            UIAction(title: "TV", handler: menuClosure),
            UIAction(title: "Person", handler: menuClosure)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.menu = menu
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    override func configureView() {
        super.configureView()
        
        title = "타이틀"

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.estimatedRowHeight = 400
        mainView.tableView.rowHeight = UITableView.automaticDimension
        
        setPopUpButton()
        
    }

}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        let row = trendList.results[indexPath.row]
        
//        switch mediaType{
//        case .person: cell.configureCell(row: row, type: .person)
//        default: cell.configureCell(row: row, type: .all)
//        }
        
        switch mediaType {
        case .all: cell.configureCell(row: row, type: .all)
        case .movie: cell.configureCell(row: row, type: .movie)
        case .tv: cell.configureCell(row: row, type: .tv)
        case .person: cell.configureCell(row: row, type: .person)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        
        detailVC.movie = trendList.results[indexPath.row]
        
//        if mediaType == .movie {
//            detailVC.movie = trendList.results[indexPath.row]
//        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
}

extension TrendViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if trendList.results.count - 1 == indexPath.row && page < 5 {
                page += 1
                
                switch mediaType {
                case .all: callRequest(page: page, type: .all)
                case .movie: callRequest(page: page, type: .movie)
                case .tv: callRequest(page: page, type: .tv)
                case .person: callRequest(page: page, type: .person)
                }
            }
        }
    }
    
}
