//
//  ViewController.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/11.
//

import UIKit

class TrendViewController: BaseViewController {

    let mainView = TrendView()
    var trendList: [Result] = []
    var page = 1
    var testList: AllTrend = AllTrend(page: 0, results: [], totalPages: 0, totalResults: 0)
    var mediaType: MediaType = .movie
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TrendViewController viewDidLoad")
        
        if mediaType == .movie {
            callRequest(page: page, type: .movie)
        } else if mediaType == .tv {
            callRequest(page: page, type: .tv)
        }
        
    }
    
    func callRequest(page: Int, type: Endpoint) {
        TmdbAPIManager.shared.callRequest(type: type, page: page) { data in
            guard let data = data else {
                print("얼럿띄우기")
                return
            }
            self.testList.results.append(contentsOf: data.results)
            self.mainView.tableView.reloadData()
        }
    }
    
    func setPopUpButton() {
        let menuClosure = { (action: UIAction) in
            print("클릭 \(action.title)")
            if action.title == "Movie" {
                self.mediaType = .movie
                self.testList.results.removeAll()
                self.callRequest(page: 1, type: .movie)
            } else if action.title == "TV" {
                self.mediaType = .tv
                self.testList.results.removeAll()
                self.callRequest(page: 1, type: .tv)
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
        print(#function)
//        return trendList.count
        return testList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
//        let row = trendList[indexPath.row]
        let row = testList.results[indexPath.row]
        if mediaType == .movie {
            cell.configureCell(row: row, type: .movie)
        } else if mediaType == .tv {
            cell.configureCell(row: row, type: .tv)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        
        detailVC.movie = trendList[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
}

extension TrendViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if testList.results.count - 1 == indexPath.row && page < 5 {
                page += 1
                if mediaType == .movie {
                    callRequest(page: page, type: .movie)
                } else if mediaType == .tv {
                    callRequest(page: page, type: .tv)
                }
            }
        }
    }
    
}
