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
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TrendViewController viewDidLoad")
        callRequest(page: page)
        
    }
    
    func callRequest(page: Int) {
        TmdbAPIManager.shared.callRequest(type: .movie, page: page) { movie in
            guard let movie = movie else {
                print("얼럿띄우기")
                return
            }
            self.trendList.append(contentsOf: movie.results)
            self.mainView.tableView.reloadData()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        title = "타이틀"

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.estimatedRowHeight = 400
        mainView.tableView.rowHeight = UITableView.automaticDimension
    }

}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return trendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        let row = trendList[indexPath.row]
        cell.configureCell(row: row)
        
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
            if trendList.count - 1 == indexPath.row && page < 5 {
                page += 1
                callRequest(page: page)
            }
        }
    }
    
}
